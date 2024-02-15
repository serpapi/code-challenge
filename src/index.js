//puppeteer is a really cool .js framework that makes scraping 
//and testing a breeze (albeit cpu intensive 😒)
const puppeteer = require('puppeteer');
const path = require('path');

//node's file system to save the scraped data to a file (.json in this case)
const fs = require('fs');

//should create a relative path on your local machine to find the .html file
const url = 'file:' + path.resolve(__dirname, '../files/van-gogh-paintings.html');


const vanGoghScrape = async () => {
    //spins up a headless browser and navigates to specified url
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(url);

    const scrapedData = await page.$$eval('.klbar .klitem', 
    (elements) => elements.map(e => ({
        name: e.querySelector('.kltat').innerText
    })))

    console.log(scrapedData);
    
    await browser.close();
}

vanGoghScrape();