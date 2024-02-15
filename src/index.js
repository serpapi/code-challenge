//puppeteer is a really cool .js framework that makes scraping 
//and testing a breeze (albeit cpu intensive 😒)
const puppeteer = require('puppeteer');
const path = require('path');

//node's file system to save the scraped data to a file (.json in this case)
const fs = require('fs');

//should create a relative path on your local machine to find the .html file
const url = 'file:' + path.resolve(__dirname, '../files/van-gogh-paintings.html');


const vanGoghScrape = async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(url);


    await browser.close();
}

vanGoghScrape();