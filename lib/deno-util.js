import { readLines } from "https://deno.land/std@0.129.0/io/bufio.ts";
import jsdom from "https://jspm.dev/npm:jsdom-deno@19.0.1";

const { JSDOM } = jsdom;

export { getTextFromReader, parseDocument };

async function getTextFromReader(reader) {
    const lines = [];
    for await (const line of readLines(reader)) {
        lines.push(line);
    }
    return lines.join("\n");
}

async function parseDocument(html) {
    const virtualConsole = new jsdom.VirtualConsole(); // disable logs from the page
    const { window } = new JSDOM(patchHTML(html), {
        runScripts: "dangerously",
        virtualConsole
    });
    return window.document;
}

function patchHTML(html) {
    const REGEXP_HEAD_TAG = /<head>/gi;
    const REGEXP_SET_IMG_SRC = /function _setImagesSrc/gi;
    const REPLACEMENT_SET_IMG_SRC = "window._setImagesSrc = _setImagesSrc; function _setImagesSrc";
    const INJECTED_SCRIPT = `<script>(${emulateLargeScreen.toString()})()</script>`;
    const REPLACEMENT_HEAD_TAG = `<head>${INJECTED_SCRIPT}`;
    return html
        .replace(REGEXP_HEAD_TAG, REPLACEMENT_HEAD_TAG)
        .replaceAll(REGEXP_SET_IMG_SRC, REPLACEMENT_SET_IMG_SRC); // make sure _setImagesSrc is global (jsdom bug)
}

function emulateLargeScreen() {
    window.document.documentElement.__defineGetter__("clientWidth", () => Infinity)
}