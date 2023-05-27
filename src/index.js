import {readFileSync} from "fs";
import {extractGoogleSearchResultCarousel} from "./lib.js";

const baseURI = "https://www.google.com/";
const html = readFileSync("./files/van-gogh-paintings.html").toString();

const result = {};
result["artworks"] = extractGoogleSearchResultCarousel(html, baseURI);

console.log(result);
