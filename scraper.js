const path =
  "/Users/kristinastefanelli/Documents/serpapi/code-challenge/files/van-gogh-paintings.html";
const defaultUrl = `file://${path}`;

const scraperObject = {
  async scrape(browser, url = defaultUrl) {
    try {
      const page = await browser.newPage();
      await page.goto(url);

      const data = await page.$$eval(".klitem", (elements) => {
        return elements.map((e) => {
          const link = e.getAttribute("href");
          const nameElement = e.querySelector(".kltat");
          const name = nameElement ? nameElement.textContent.trim() : null;
          const extensionsNode = e.querySelector(".klmeta");
          const extensions = extensionsNode
            ? [extensionsNode.textContent.trim()]
            : [];
          const img = e.querySelector("img");
          const image = img ? img.getAttribute("src") : null;

          return { link, name, extensions, image };
        });
      });

      console.log("Scraped Data:", data);

      return data;
    } catch (err) {
      console.error("Error:", err);
      return [];
    }
  },
};

module.exports = scraperObject;
