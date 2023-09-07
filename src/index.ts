import { readFile } from "node:fs/promises";
import * as cheerio from "cheerio";
import path from "path";

(async () => {
  const htmlFile = await readFile(
    path.resolve("files/van-gogh-paintings.html"),
  );
  const $ = cheerio.load(htmlFile);
  const caroselTableRows = $(".klitem-tr .klitem").toArray();

  const extractedRows = caroselTableRows.map((row) => {
    const { attributes } = row;

    let title: string | undefined;
    let link: string | undefined;
    let name: string | undefined;
    const extensions: string[] = [];

    attributes.forEach((a) => {
      switch (a.name) {
        case "title":
          title = a.value;
          break;
        case "href":
          link = a.value;
          break;
        case "aria-label":
          name = a.value;
          break;
        default:
          break;
      }
    });

    const hasExtensions = title !== name;
    if (title && hasExtensions) {
      const left = title.indexOf("(");
      const right = title.indexOf(")");

      const hasYearExtension = left > -1 && right > -1;
      if (hasYearExtension) {
        const year = title.substring(left + 1, right);
        extensions.push(year);
      }
    }

    return {
      name,
      link,
      extensions,
    };
  });
})();
