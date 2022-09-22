const path = 'C:\\Users\\schaf\\git-repos\\serp-api-code-challenge\\files\\van-gogh-paintings.html';
const scraperObject = {
	url: path,
	async scrape(browser){
		let page = await browser.newPage();
		console.log(`Opening ${this.url}...`);
		await page.goto(this.url);
            
            console.log("loaded page");
            let data = await page.$$eval('.klitem', elements => {
                return elements.map(e => {
                    // extract google search link
                    let searchLink = e.getAttribute('href');
                    //extract title
                    let divs = e.querySelectorAll(':scope > div');
                    let titleNode = divs[1].querySelector('.kltat');
                    let title = titleNode.textContent;
                    //extract extensions
                    let extentionNode = divs[1].querySelector('.klmeta');
                    let extensions = [];
                    if(extentionNode != null){
                        extensions.push(extentionNode.textContent);
                    }
                    //extract thumbnails
                    let img = e.querySelector('img');
                    let imgSrc;
                    if(img!=null){
                        imgSrc = img.getAttribute('src');
                    }

                    return {title, extensions, searchLink, imgSrc};
                })
                
            });
            console.log(data);
            return data;
    }
        
		
	
}

module.exports = scraperObject;