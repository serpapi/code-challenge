const scraper = require('./scraper.js');
async function scrapeAll(browserInstance){
	let browser;
	try{
		browser = await browserInstance;
		await scraper.scrape(browser);	
		
	}
	catch(err){
		console.log("Error: Could not resolve browser instance => ", err);
	}
}

module.exports = (browserInstance) => scrapeAll(browserInstance);