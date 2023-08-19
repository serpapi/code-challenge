const path = require("path");
const puppeteer = require("puppeteer");

(async () => {
  const browser = await puppeteer.launch({ headless: "new" });
  const page = await browser.newPage();

  const filePath = path.join(__dirname, "../files/van-gogh-paintings.html");

  const content = await page
    .goto(`file://${filePath}`)
    .then(() => page.content());

  await page.waitForSelector("g-scrolling-carousel a.klitem", {
    visible: true,
  });

  const scrapedData = await page.evaluate(async () => {
    const items = Array.from(
      document.querySelectorAll("g-scrolling-carousel a.klitem")
    );

    const extractedData = [];

    for (const item of items) {
      const name = item.getAttribute("aria-label");
      const extensions = [item.querySelector(".klmeta")?.textContent];
      const link = "https://google.com" + item.getAttribute("href");
      const image = item.querySelector("img").getAttribute("src");

      extractedData.push({ name, extensions, link, image });
    }

    return extractedData;
  });

  await browser.close();

  console.log(JSON.stringify({ artworks: scrapedData }, null, "  "));
})();
