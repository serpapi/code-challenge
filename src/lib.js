import * as cheerio from 'cheerio';

export function extractGoogleSearchResultCarousel(html, baseURI) {
    const results = [];

    // Loading cheerio client
    const $ = cheerio.load(html, {
        baseURI
    });


    // Processing the carousel
    $("g-scrolling-carousel .klitem-tr").each((i, el) => {
        const row = {};

        row["name"] = $(el).find(".kltat").text();

        const extensionData = $(el).find(".klmeta").text();
        if (extensionData !== "") {
            row["extensions"] = extensionData.split(', ');
        }

        row["link"] = $(el).find(">a").prop("href");
        row["image"] = $(el).find("g-img img").prop("src") ?? null;

        results.push(row);
    });

    return results;
}
