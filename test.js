const playwright = require("playwright");
const { expect } = require("playwright/test");
const scraper = require("./scraper");

describe("Scraper Test", () => {
  let browser;

  beforeAll(async () => {
    browser = await playwright.chromium.launch();
  });

  afterAll(async () => {
    await browser.close();
  });

  async function testScrape(browser, url) {
    const actualData = await scraper.scrape(browser, url);

    expect(actualData).toBeTruthy();

    actualData.forEach((item, index) => {
      console.log(`Item ${index + 1}:`, item);

      expect(item).toHaveProperty("link");
      expect(typeof item.link).toBe("string");
      expect(item.link).toBeDefined();

      expect(item).toHaveProperty("name");
      expect(typeof item.name).toBe("string");
      expect(item.name).toBeDefined();

      expect(item).toHaveProperty("extensions");
      expect(Array.isArray(item.extensions)).toBe(true);
      expect(item.extensions).toBeDefined();

      if (item.image != null) {
        expect(item).toHaveProperty("image");
        expect(typeof item.image).toBe("string");
      }
    });
  }

  it("should extract name, extensions array (date), Google link, and image", async () => {
    await testScrape(
      browser,
      "file:///Users/kristinastefanelli/Documents/serpapi/code-challenge/files/van-gogh-paintings.html"
    );
  });
});
