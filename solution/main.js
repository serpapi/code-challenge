const fs = require('fs');
const GoogleCardScraper = require("./scraper/scraper");

(async() => {
    'use strict';

    if (process.argv.length != 3) {
        console.log('Usage: node main.js <html source>');
        return;
    }

    const html = fs.readFileSync(process.argv[2], 'utf-8');
    const target = 'https://www.google.com';
    const scraper = new GoogleCardScraper(html, target);

    try {
        const results = scraper.getCards();
        console.log(results)
    
        fs.writeFileSync('output/out.json', JSON.stringify({
            "artworks": results,
        }));
    } catch (err) {
        console.log(err)
        console.log(`failed to process results, check your input file: ${err.message}`);
    } 
})();