import { readFile } from "node:fs/promises";
import * as cheerio from "cheerio";
import path from "path";

(async () => {
  const htmlFile = await readFile(
    path.resolve("files/van-gogh-paintings.html"),
  );
  const $ = cheerio.load(htmlFile);
  const caroselTableRows = $(".klitem-tr").toArray();
})();
