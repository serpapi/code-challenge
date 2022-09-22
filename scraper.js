
const path = 'C:\\Users\\schaf\\git-repos\\serp-api-code-challenge\\files\\van-gogh-paintings.html';
const items = [];
const scraperObject = {
	url: path,
	async scrape(browser){
		let page = await browser.newPage();
		console.log(`Opening ${this.url}...`);
		await page.goto(this.url);
            
            console.log("loaded page");
    }
        
		
	
}

module.exports = scraperObject;