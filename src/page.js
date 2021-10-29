const puppeteer = require('puppeteer');

async function init() {
  try {
    const browser = await puppeteer.launch({ headless: true });
    console.log('Browser is ready...');
    return browser;
  } catch (e) {
    console.log('Failed to start browser.');
    process.exit(1);
  }
}

async function open(browser, url) {
  let page;
  try {
    page = await browser.newPage();
    await page.goto(url);

    return await page.$$eval('g-scrolling-carousel a[aria-label]', (carousels) => {
      return carousels.map(carousel => {
        const extractedInfo = {
          "name": carousel.ariaLabel,
          "link": `${carousel.href.replace('file://', 'https://www.google.com')}`,
        };
        const extensionText = carousel.innerText
          .replace('-\n', '-') // title in the card breaks at '-', eg, line1: Service-\n, line2: Orient...
          .replace('\n', ' ')
          .replace(carousel.ariaLabel, '').trim();
        if(extensionText) extractedInfo.extensions = [ extensionText ];
        const imgElement = carousel.querySelector('img');
        if(imgElement.dataset.lzy_) { 
          // lazy loaded image, set to null
          extractedInfo.image = null;
        } else {
          extractedInfo.image = imgElement.src || null;
        }
        return extractedInfo;
      });
    });
  } catch(e) {
    console.log(e);
    throw e;
  } finally {
    if(page != null) {
      await page.close();
    }
  }
}
module.exports = { init, open };