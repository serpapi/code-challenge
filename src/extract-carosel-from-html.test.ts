import { describe, expect, test } from "@jest/globals";
import { readFile } from "node:fs/promises";
import path from "node:path";

import { parseHtml } from "./extract-carosel-from-html";

import expectedOutput from "../files/expected-array.json";

describe("extract carosel from html", () => {
  test("should parse html to expected output", async () => {
    const htmlFile = (
      await readFile(path.resolve("files/van-gogh-paintings.html"))
    ).toString();

    console.log(htmlFile);

    const results = await parseHtml(htmlFile);
    expect(results).toBe(expectedOutput);
  });
});
