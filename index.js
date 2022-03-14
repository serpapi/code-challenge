import { getTextFromReader, parseDocument } from "./lib/deno-util.js";
import { patch } from "./lib/html-util.js";
import { getCarouselData } from "./lib/g-scrolling-carousel.js";

const JSON_INDENTING_SPACES = 2;

const html = await getTextFromReader(Deno.stdin);
const htmlPatched = patch(html);
const document = parseDocument(htmlPatched);
const carouselData = getCarouselData(document);
const json = JSON.stringify(carouselData, null, JSON_INDENTING_SPACES);
console.log(json);
Deno.exit();