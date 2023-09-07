import { readFile } from "node:fs/promises";
import * as cheerio from "cheerio";
import path from "path";
import { parseHtml } from "./extract-carosel-from-html";

(async () => {
  const htmlFile = (
    await readFile(path.resolve("files/van-gogh-paintings.html"))
  ).toString();

  await parseHtml(htmlFile);
})();
