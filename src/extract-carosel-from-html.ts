import * as cheerio from "cheerio";

interface Result {
  link?: string;
  name?: string;
  image: string | null;
  extensions?: string[];
}

export const parseHtml = (html: string) => {
  const $ = cheerio.load(html);
  const caroselTableRows = $(".klitem-tr .klitem").toArray();

  const extractedRows = caroselTableRows.map((row) => {
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
