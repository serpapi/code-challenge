//puppeteer is a really cool .js framework that makes scraping 
//and testing a breeze (albeit cpu intensive 😒)
const puppeteer = require('puppeteer');

//node's file system to save the scraped data to a file (.json in this case)
const fs = require('fs');

const url = 'file:/Users/greenteaisgreat/Desktop/Junior-Full-Stack-Code-Challenge/files/van-gogh-paintings.html';


const vanGoghScrape = async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(url);

    const screenshot = await page.screenshot({ path: 'example.png', fullPage: true });

    await browser.close();
}

vanGoghScrape();