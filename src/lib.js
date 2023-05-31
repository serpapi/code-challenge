import {JSDOM} from 'jsdom';


export function textContentToPlainText(data) {
    data = data.replace(/(\r|\n)*/g, "").replace(/ {2,}/g, " ").trim();
    return data;
}

export function extractGoogleSearchResultCarousel(html, baseURI) {
    const results = [];

    // Loading JSDOM client
    const dom = new JSDOM(html, {
            url: baseURI,
            runScripts: "dangerously"
        }
    );

    // Processing the carousel
    dom.window.document.querySelectorAll("g-scrolling-carousel .klitem-tr").forEach((el) => {
        const row = {};

        row["name"] = textContentToPlainText(el.querySelector(".kltat").textContent);

        const extensionEl = el.querySelector(".klmeta");
        if (extensionEl !== null) {
            row["extensions"] = textContentToPlainText(extensionEl.textContent).split(', ');
        }


        row["link"] = el.querySelector(":scope a").href;

        const imageEl = el.querySelector("g-img img");
        row["image"] = imageEl.src.length > 0 ? imageEl.src : null;

        results.push(row);
    });

    dom.window.close();
    return results;
}
