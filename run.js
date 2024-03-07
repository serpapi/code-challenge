const fs = require("fs");
const { parseGScrollingCarousel } = require("./parse-carousel");

/**
 * parse an html string from stdin and write the result to stdout, all sync, no streaming
 * @returns {void}
 */
function run() {
  const html = fs.readFileSync(0, "utf-8");

  const parsedCarousel = parseGScrollingCarousel(html);

  fs.writeFileSync(1, JSON.stringify(parsedCarousel, null, 2), "utf-8");
}

run();
