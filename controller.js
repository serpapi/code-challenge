const scraper = require("./scraper.js");

async function scrapeAll(browserInstance) {
  try {
    const browser = await browserInstance;
    await scraper.scrape(browser);
  } catch (err) {
    console.log("Error: Could not resolve browser instance => ", err);
  }
}

module.exports = (browserInstance) => scrapeAll(browserInstance);
