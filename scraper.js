
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
                    let searchLink = e.getAttribute('href');
                    
                    let divs = e.querySelectorAll(':scope > div');
                    let titleNode = divs[1].querySelector('.kltat');
                    let titleText = titleNode.textContent;
                    
                    let extentionNode = divs[1].querySelector('.klmeta');
                    let extensionText;
                    if(extentionNode != null){
                        extensionText = extentionNode.textContent;
                    }
                    
                    let img = e.querySelector('img');
                    let imgSrc;
                    if(img!=null){
                        imgSrc = img.getAttribute('src');
                    }

                    return [titleText, extensionText, searchLink, imgSrc];
                })
                
            });
            let titles = await text;
            console.log(titles);
    }
        
		
	
}

module.exports = scraperObject;