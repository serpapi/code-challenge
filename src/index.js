//puppeteer is a really cool .js framework that makes scraping 
//and testing a breeze (albeit cpu intensive 😒)
const puppeteer = require('puppeteer');
const path = require('path');

//node's file system to save the scraped data to a file (.json in this case)
const fs = require('fs');

//should create a relative path on your local machine to find the .html file
const url1 = 'file:' + path.resolve(__dirname, '../files/van-gogh-paintings.html');


const vanGoghScrape = async (url) => {
    //spins up a headless browser and navigates to specified url
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(url);
   
    
    //this puppeteer method uses a combination of Array.from() & .querySelectorAll()
    //to scrape through every selector passed in as the first argument(s)
    const scrapedData = await page.$$eval('.klbar .klitem', 
    (elements) => elements.map(e => ({
        name: e.querySelector('.kltat').innerText,
        extensions: [e.querySelector('.ellip.klmeta')?.innerText],
        link: e.href,
        image: e.querySelector('img').src
    })));


    //save the scraped data to a .json file, with error handling
    fs.writeFile('vanGoghData.json', 
    JSON.stringify(scrapedData, null, scrapedData.length), (err) => {
        if (err) throw new Error('There was an error writing the scraped data');
        console.log('Scraped data successfully written!');
    });

    await browser.close();
}

vanGoghScrape(url1);