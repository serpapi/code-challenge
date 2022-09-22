
const path = 'C:\\Users\\schaf\\git-repos\\serp-api-code-challenge\\files\\van-gogh-paintings.html';
const items = [];
const scraperObject = {
	url: path,
	async scrape(browser){
		let page = await browser.newPage();
		console.log(`Opening ${this.url}...`);
		await page.goto(this.url);
            
            console.log("loaded page");
            let text = await page.$$eval('.klitem', elements => {
                return elements.map(e => {
                    let divs = e.querySelectorAll(':scope > div');
                    let titleNode = divs[1].querySelector('.kltat');
                    let titleText;
                    if(titleNode != null){
                        // let nodeClass = titleNode.getAttribute('class');
                        // console.log(nodeClass);
                        titleText = titleNode.textContent;
                    }
                    else{
                        console.log("could not find element with class .kltat")
                    }
                    // let title = e.getAttribute('aria-label');
                    return titleText;
                })
                
            });
            let titles = await text;
            console.log(titles);
    }
        
		
	
}

module.exports = scraperObject;