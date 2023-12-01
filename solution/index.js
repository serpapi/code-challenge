const { parse } = require('node-html-parser');
const fs = require('fs');

async function readHtml() {
    try {
      const artwork = []
      const htmlContent = await fs.readFileSync('./van-gogh-paintings.html', 'utf-8');
      const root = parse(htmlContent);
      const parentNode = root.querySelector('g-scrolling-carousel>div>div');
      parentNode.childNodes.forEach((node) => {
        let childRootNode = node.querySelector('[title]');
        let name = childRootNode.getAttribute('aria-label');
        let extension = childRootNode.querySelector('div:nth-child(2) > .ellip');
        let link = 'https://www.google.com' + childRootNode.getAttribute('href');
        let image = childRootNode.querySelector('.klic>g-img>img') || childRootNode.querySelector('img');
        let scrappedData = {
            name: name ? name : '',
            extensions: extension ? [extension.innerText]: [],
            link: link ? link : '',
            image: image ? image.getAttribute('src') : null
        };
        artwork.push(scrappedData);
      })
      return artwork;
    } catch (error) {
      console.error('Error reading HTML:', error);
    }
}
async function main() {
    const resultArray = await readHtml();
    console.log(resultArray);
  }
  
main();