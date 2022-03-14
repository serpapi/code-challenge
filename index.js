import { getTextFromReader, parseDocument } from "./lib/deno-util.js";
import { getCarouselData } from "./lib/g-scrolling-carousel.js";
import { patchHTML } from "./lib/page-util.js";

const JSON_INDENTING_SPACES = 2;

let html = await getTextFromReader(Deno.stdin);
html = patchHTML(html);
const document = await parseDocument(html);
const carouselData = getCarouselData(document);
const json = JSON.stringify(carouselData, null, JSON_INDENTING_SPACES);
console.log(json);
Deno.exit();