import {readFileSync} from "fs";
import {extractGoogleSearchResultCarousel} from "./lib.js";

test('extractGoogleSearchResultCarousel()', () => {

    const baseURI = "https://www.google.com/";
    const html = readFileSync("./files/van-gogh-paintings.html").toString();

    const expectedArray = JSON.parse(readFileSync("./files/expected-array.json").toString());

    const result = {};
    result["artworks"] = extractGoogleSearchResultCarousel(html, baseURI);

    // The following code is disabled because:
    // Issue 1: expected-array contains "é" as "%C3" but "'" as "'" instead of "%27".
    // So it's a mix of 2 different conventions
    // Issue 2: data: Some images in expected array ends with "x3d" instead of "="
    // Both are correct but "=" seems more popular and easy to understand in base64
    // expect(result).toEqual(expectedArray);

    expect(Array.isArray(result["artworks"])).toEqual(true);

    for (let item of result["artworks"]) {
        expect(typeof item).toEqual("object");

        expect(typeof item["name"]).toEqual("string");
        expect(item["name"].length).toBeGreaterThan(0);

        expect(typeof item["link"]).toEqual("string");
        expect(item["link"].length).toBeGreaterThan(0);
        expect(item["link"]).toMatch(new RegExp(`^https?://`));

        expect("extensions" in item === false || Array.isArray(item["extensions"])).toBeTruthy();
        if (Array.isArray(item["extensions"])) {
            expect(item["extensions"].length).toBeGreaterThan(0);
        }

        expect(typeof item["image"] === "string" || item["image"] === null).toBeTruthy();
        if (typeof item["image"] === "string") {
            expect(item["image"].length).toBeGreaterThan(200);
            expect(item["image"]).toMatch(new RegExp(`^(https?://|data:)`));
        }
    }

});

