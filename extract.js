const HTMLParser = require('node-html-parser');
const fs = require('fs');
const { JSDOM } = require('jsdom');

const extractedData = () => {
    console.log('test');
    const html = fs.readFileSync('./van-gogh-paintings.html', 'utf-8');
    // const root = HTMLParser.parse(html);

    const dom = new JSDOM(html);
    const document = dom.window.document;

    const results = document.querySelectorAll('[class^="MiPcId klitem-tr mlo-c r-"]')
    console.log('results length: ', results.length);
    const paintings = [];

    for (let i = 0; i < results.length; i++) {
        let current = results[i];

        let name = current.querySelector('a')?.getAttribute('aria-label') || null;
        let extensions = current.querySelector('.ellip.klmeta');
        let link = current.querySelector('a')?.getAttribute('href') || null;
        let thumbnail = current.querySelector('img')?.getAttribute('data-key') || null;

        paintings.push({name, extensions, link, thumbnail});
    }

  console.log('paintings:', paintings);
  return paintings;
}

module.exports = extractedData;
extractedData();

