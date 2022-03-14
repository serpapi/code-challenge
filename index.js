import { getTextFromReader, parseDocument } from "./lib/deno-util.js";
import { patchHTML } from "./lib/page-util.js";
import { getCarouselData } from "./lib/g-scrolling-carousel.js";

const JSON_INDENTING_SPACES = 2;

const html = await getTextFromReader(Deno.stdin);
const patchedHtml = patchHTML(html);
const document = parseDocument(patchedHtml);
const carouselData = getCarouselData(document);
const json = JSON.stringify(carouselData, null, JSON_INDENTING_SPACES);
console.log(json);
Deno.exit();