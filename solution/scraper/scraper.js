const vm = require('vm');
const JSDOM = require('jsdom').JSDOM;

class GoogleCardScraper {
    constructor(sourceHTML, target) {
        this.dom = new JSDOM(sourceHTML);;
        this.target = target;
    }

    getCards() {
        const scripts = this.dom.window.document.querySelectorAll("script");
        
        const ctx = {
            window: this.dom.window,
            document: this.dom.window.document,
            google: {},
        };
    
        const context = vm.createContext(ctx);
    
        scripts.forEach((el) => {
            try {
                vm.runInContext(el.textContent, context)
            } catch {}
        });

        const results = [];
    
        const selectedCards = this.dom.window.document.querySelectorAll('g-scrolling-carousel a');
        for (let i = 0; i < selectedCards.length; i++) {
            const eachCard = selectedCards[i];
    
            const card = {};
    
            const name = eachCard.attributes.getNamedItem('title');
            if (!name) {
                continue;
            }
            card.name = name.nodeValue;
    
            card.link = `${this.target}${eachCard.attributes.getNamedItem('href').nodeValue}`;
    
            const img = extractImage(eachCard);
            card.image = img;
            
            const meta = eachCard.querySelectorAll('.klmeta');
            card.extensions = meta ? Array.from(meta).map(m => m.textContent.replaceAll(/[\s]{2,}/g, ' ').trimRight()) : [];
    
            results.push(card);
        }

        return results;
    }
}

function extractImage(card) {
    const img = card.querySelector('g-img > img');
    if (!img) return null;

    const src = img.attributes.getNamedItem('src');
    if (!src) return null;

    return src.nodeValue;
}

module.exports = GoogleCardScraper;
