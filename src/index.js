const path = require('path');
const { init, open } = require('./page');

async function parse(url) {
  let browser = await init();
  try {
    return await open(browser, url);
  } finally {
    console.log('Close browser...');
    await browser.close();
  }
}

module.exports = { parse };