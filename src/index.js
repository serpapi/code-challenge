import {readFileSync, writeFileSync} from "fs";
import {extractGoogleSearchResultCarousel} from "./lib.js";

const baseURI = "https://www.google.com/";
const html = readFileSync("./files/van-gogh-paintings.html").toString();

const result = {};
result["artworks"] = extractGoogleSearchResultCarousel(html, baseURI);

writeFileSync("./files/actual-array.json", JSON.stringify(result, null, 2))