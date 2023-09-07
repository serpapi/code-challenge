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

export const parseScriptForImages = (
  scriptData: string,
  idToImageDataMap: Record<string, ImageData> = {},
) => {
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

    let state:
      | "initial"
      | "parsing_image"
      | "done_parsing_image"
      | "parsing_id" = "initial";

    for (let i = 0; i < splits.length; i++) {
      if (splits[i].indexOf("var") > -1) {
        if (state === "initial") {
          state = "parsing_image";
          continue;
        } else if (state === "done_parsing_image") {
          state = "parsing_id";
          continue;
        }
      }

      if (state === "parsing_image") {
        if (splits[i].indexOf("data:image") > -1) {
          const imageFirstPart = extractStringValue(splits[i]);
          item.imageData = imageFirstPart;
        } else if (splits[i].indexOf("base64") > -1) {
          const imageSecondPart = extractString(splits[i]).replaceAll("\\", "");
          if (item.imageData) {
            item.imageData += `;${imageSecondPart}`;
          }
          state = "done_parsing_image";
        }
      }

      if (
        state === "parsing_id" &&
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
  const setImageScripts = scripts.filter((s) => {
    const firstChild = s.children[0] as CheerioText;
    if (!firstChild) {
      return false;
    }
    return (
      firstChild.data.indexOf("_setImagesSrc") > -1 &&
      firstChild.data.indexOf("data:image") > -1
    );
  });

  if (setImageScripts) {
    const idToImageDataMap: Record<string, ImageData> = {};

    setImageScripts.forEach((script) => {
      parseScriptForImages(
        (script.children[0] as CheerioText).data,
        idToImageDataMap,
      );
    });

    return idToImageDataMap;
  }
};

export const parseHtml = (html: string) => {
  const $ = cheerio.load(html);
  const scripts = $("script").toArray();

  const idToImageDataMap = parseScript(scripts);

  if (!idToImageDataMap) {
    throw new Error("Failed to parse script for images");
  }

  let caroselTableImages = $(".klitem-tr .klitem img").toArray();
  let caroselTableRows = $(".klitem-tr .klitem").toArray();

  if (caroselTableImages.length === 0 || caroselTableRows.length === 0) {
    caroselTableImages = $(".pla-unit .pla-unit-img-container img").toArray();
    caroselTableRows = $(
      ".pla-unit .pla-unit-single-clickable-target",
    ).toArray();
  }

  const extractedRows = caroselTableRows.map((row, index) => {
    const { attributes } = row;

    const result: Result = {
      image: null,
    };

    const image = caroselTableImages[index];
    if (image) {
      const imageId = image.attribs.id;
      const imageData = idToImageDataMap[imageId];
      if (imageData?.imageData) {
        result.image = imageData.imageData;
      }
    }

    let title: string | undefined;

    attributes.forEach((a) => {
      switch (a.name) {
        case "title":
          title = a.value;
          break;
        case "href":
          if (a.value.indexOf("http") === -1) {
            result.link = `https://www.google.com${a.value}`;
          } else {
            result.link = a.value;
          }
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
