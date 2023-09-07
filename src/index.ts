import { readFile, writeFile } from "node:fs/promises";
import * as cheerio from "cheerio";
import path from "path";
import { parseHtml } from "./extract-carosel-from-html";

(async () => {
  // const htmlFileName = "van-gogh-paintings"
  const htmlFileName = "best-running-shoes-2023-09-07";

  const htmlFile = (
    await readFile(path.resolve(`files/${htmlFileName}.html`))
  ).toString();

  const output = await parseHtml(htmlFile);

  await writeFile(
    path.resolve(`output/${htmlFileName}.json`),
    JSON.stringify(output, undefined, 2),
  );
})();
