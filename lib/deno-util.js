import { readLines } from "https://deno.land/std@0.129.0/io/bufio.ts";
import jsdom from "https://jspm.dev/npm:jsdom-deno@19.0.1";

const { JSDOM } = jsdom;

console.warn = () => { }; // disable warnings from jsdom

export { getTextFromReader, parseDocument };

async function getTextFromReader(reader) {
    const lines = [];
    for await (const line of readLines(reader)) {
        lines.push(line);
    }
    return lines.join("\n");
}

function parseDocument(html) {
    const virtualConsole = new jsdom.VirtualConsole(); // disable logs from the page
    const { window } = new JSDOM(html, {
        runScripts: "dangerously",
        virtualConsole
    });
    return window.document;
}