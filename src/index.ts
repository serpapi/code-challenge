import { readFile, writeFile } from "node:fs/promises";
import * as cheerio from "cheerio";
import path from "path";
import { parseHtml } from "./extract-carosel-from-html";

if (process.argv.length === 2) {
  console.error("Expected at least one argument!");
  process.exit(1);
}

(async () => {
  const htmlFileName = process.argv[2] || "van-gogh-paintings";
  const htmlFile = (
    await readFile(path.resolve(`files/${htmlFileName}.html`))
  ).toString();

  const output = await parseHtml(htmlFile);

  await writeFile(
    path.resolve(`output/${htmlFileName}.json`),
    JSON.stringify(output, undefined, 2),
  );
})();
