const path = require("path");
const puppeteer = require("puppeteer");

describe("Scraping Test for paintings-picasso.html", () => {
  let browser;
  let page;
  let scrapedData;

  beforeAll(async () => {
    browser = await puppeteer.launch({ headless: "new" });
    page = await browser.newPage();

    const filePath = path.join(__dirname, "../html/paintings-picasso.html");
    await page.goto(`file://${filePath}`);
    await page.waitForSelector("g-scrolling-carousel a.klitem", {
      visible: true,
    });

    scrapedData = await page.evaluate(async () => {
      const items = Array.from(
        document.querySelectorAll("g-scrolling-carousel a.klitem")
      );

      const extractedData = [];

      for (const item of items) {
        const name = item.getAttribute("aria-label");
        const extensions = [item.querySelector(".klmeta")?.textContent];
        const link = "https://www.google.com" + item.getAttribute("href");
        const image = item.querySelector("img").getAttribute("src");

        extractedData.push({ name, extensions, link, image });
      }

      return extractedData;
    });
  });

  afterAll(async () => {
    await browser.close();
  });

  test("Scraped data should have non-empty values", () => {
    expect(Array.isArray(scrapedData)).toBe(true); // Confirm data is an array

    scrapedData.forEach((data) => {
      expect(data.name).toBeTruthy(); // Confirm name is not empty
      expect(data.extensions).toBeTruthy(); // Confirm extensions is not empty
      expect(data.link).toBeTruthy(); // Confirm link is not empty
      expect(data.link).toMatch(/^https?:\/\/.+$/); // Confirm link is a URL
      expect(data.image).toBeTruthy(); // Confirm image is not empty
      expect(data.image).toMatch(/^data:image\/\w+;base64,.+$/); // Confirm image is a base64 string
    });
  });
});
