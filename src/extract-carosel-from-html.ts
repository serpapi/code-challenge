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
  return s.substring(equalStartAt + 1, semiColonEndAt);
};

const extractStringValue = (s: string) => {
  const val = extractValue(s);
  return val.substring(1, val.length - 1);
};

export const parseScriptForImages = (scriptData: string) => {
  const idToImageMap: Record<string, ImageData> = {};

  const functions = scriptData.split("function");

  functions.forEach((f: string) => {
    const splits = f
      .split(/(\s)/)
      .map((s) => s.trim())
      .filter((s) => s.length > 0);

    console.log(splits);

    const item: ImageData = {};

    for (let i = 0; i < splits.length; i++) {
      if (splits[i] == "var" && splits[i + 1].indexOf("data:image") > -1) {
        const imageData = extractStringValue(splits[i + 1]);
        console.log(decodeURIComponent(imageData));
        item.imageData = imageData;
      }
      if (splits[i] == "var" && splits[i + 1].indexOf("ii=[") > -1) {
        try {
          const idArray = JSON.parse(extractValue(splits[i + 1]));
          item.id = idArray[0];
        } catch {}
      }
    }

    if (item.id) {
      idToImageMap[item.id] = item;
    }
  });

  return idToImageMap;
};

export const parseScript = (scripts: cheerio.Element[]) => {
  const setImageScript = scripts.find(
    (s) => (s.children[0] as CheerioText).data.indexOf("_setImagesSrc") > -1,
  );

  if (setImageScript) {
    parseScriptForImages((setImageScript.children[0] as CheerioText).data);
  }

  return setImageScript;
};

export const parseHtml = (html: string) => {
  const $ = cheerio.load(html);
  const scripts = $("script").toArray();

  parseScript(scripts);

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
