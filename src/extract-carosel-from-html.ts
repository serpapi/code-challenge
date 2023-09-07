import * as cheerio from "cheerio";

interface Result {
  link?: string;
  name?: string;
  image: string | null;
  extensions?: string[];
}

interface ImageData {
  id?: string;
  imageData?: string;
}

interface CheerioText {
  data: string;
}

const extractValue = (s: string) => {
  const equalStartAt = s.indexOf("=");
  const semiColonEndAt = s.lastIndexOf(";");
  return s.substring(
    equalStartAt > 0 ? equalStartAt + 1 : 0,
    semiColonEndAt > -1 ? semiColonEndAt : s.length,
  );
};

const extractString = (s: string) => {
  return s.replaceAll('"', "").replaceAll("'", "");
};

const extractStringValue = (s: string) => {
  const val = extractValue(s);
  return extractString(val);
};

export const parseScriptForImages = (scriptData: string) => {
  const idToImageDataMap: Record<string, ImageData> = {};

  const functions = scriptData
    .split("function")
    .filter((s) => s.indexOf("base64") > -1);

  functions.forEach((f: string) => {
    const splits = f
      .split(/[ ;]+/)
      .map((s) => s.trim())
      .filter((s) => s.length > 0);

    console.log(splits);

    const item: ImageData = {};

    let parsingImage = false;
    let parsingId = false;

    for (let i = 0; i < splits.length; i++) {
      if (splits[i].indexOf("var") > -1) {
        if (!parsingImage) {
          parsingImage = true;
        } else if (parsingImage) {
          parsingImage = false;
          parsingId = true;
        }
        continue;
      }

      if (parsingImage) {
        if (splits[i].indexOf("data:image") > -1) {
          const imageFirstPart = extractStringValue(splits[i]);
          item.imageData = imageFirstPart;
        } else if (splits[i].indexOf("base64") > -1) {
          const imageSecondPart = extractString(splits[i]);
          if (item.imageData) {
            item.imageData += `;${imageSecondPart}`;
          }
        }
      }

      if (
        parsingId &&
        (splits[i].indexOf('["') > -1 || splits[i].indexOf("['") > -1)
      ) {
        try {
          const val = extractValue(splits[i]);
          const idArray = JSON.parse(val.replaceAll("'", '"'));
          item.id = idArray[0];
        } catch (error) {
          console.error("Failed to parse: ", error);
        }
      }
    }

    if (item.id) {
      idToImageDataMap[item.id] = item;
    }
  });

  return idToImageDataMap;
};

export const parseScript = (scripts: cheerio.Element[]) => {
  const setImageScript = scripts.find(
    (s) => (s.children[0] as CheerioText).data.indexOf("_setImagesSrc") > -1,
  );

  if (setImageScript) {
    return parseScriptForImages(
      (setImageScript.children[0] as CheerioText).data,
    );
  }
};

export const parseHtml = (html: string) => {
  const $ = cheerio.load(html);
  const scripts = $("script").toArray();

  const caroselTableImages = $(".klitem-tr .klitem img").toArray();
  const caroselTableRows = $(".klitem-tr .klitem").toArray();

  const extractedRows = caroselTableRows.map((row, index) => {
    const { attributes } = row;

    const result: Result = {
      image: null,
    };

    let title: string | undefined;

    attributes.forEach((a) => {
      switch (a.name) {
        case "title":
          title = a.value;
          break;
        case "href":
          result.link = `https://www.google.com${a.value}`;
          break;
        case "aria-label":
          result.name = a.value;
          break;
        default:
          break;
      }
    });

    const hasExtensions = title !== result.name;
    if (title && hasExtensions) {
      const left = title.indexOf("(");
      const right = title.indexOf(")");

      const hasYearExtension = left > -1 && right > -1;
      if (hasYearExtension) {
        const year = title.substring(left + 1, right);

        if (!result.extensions) {
          result.extensions = [];
        }
        result.extensions.push(year);
      }
    }

    return result;
  });

  return {
    artworks: extractedRows,
  };
};
