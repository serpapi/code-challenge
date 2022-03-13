import { readLines } from "https://deno.land/std@0.129.0/io/bufio.ts";
import { JSDOM } from "https://jspm.dev/npm:jsdom-deno@19.0.1";

export { getTextFromReader, parseDocument };

async function getTextFromReader(reader) {
    const lines = [];
    for await (const line of readLines(reader)) {
        lines.push(line);
    }
    return lines.join();
}

async function parseDocument(html) {
    const { document } = new JSDOM(html).window;
    return document;
}