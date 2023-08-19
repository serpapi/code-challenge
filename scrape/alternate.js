// pass the html file via cli
// node alternate /html/paintings-warhol.html

const path = require("path");
const puppeteer = require("puppeteer");

(async () => {
  const browser = await puppeteer.launch({ headless: "new" });
  const page = await browser.newPage();

  const filePath = path.join(__dirname, process.argv[2]);

  const content = await page
    .goto(`file://${filePath}`)
    .then(() => page.content());

  await page.waitForSelector(".iELo6", {
    visible: true,
  });

  const scrapedData = await page.evaluate(async () => {
    const items = Array.from(document.querySelectorAll(".iELo6"));

    const extractedData = [];

    for (const item of items) {
      const name = item.querySelectorAll("div")[1].textContent;
      const extensions = [item.querySelectorAll("div")[2].textContent];
      const link =
        "https://google.com" + item.querySelector("a").getAttribute("href");
      const image = item.querySelector("img").getAttribute("src");

      extractedData.push({ name, extensions, link, image });
    }

    return extractedData;
  });

  await browser.close();

  console.log(JSON.stringify({ artworks: scrapedData }, null, "  "));
})();
