const fs = require('fs');
const { JSDOM } = require('jsdom');

const extractPaintingsData = () => {
  const vanGoghPaintingsHTML = './van-gogh-paintings.html'; // Path to search result page provided
  const content = fs.readFileSync(vanGoghPaintingsHTML, 'UTF-8'); // read html and return content
  // console.log('Returned content from fs:', content);


  const dom = new JSDOM(content);
  const document = dom.window.document; // create DOM document environment
  // console.log('Document returned from JSDOM:', document.documentElement.outerHTML);

  const carouselItems = document.querySelectorAll('[class^="MiPcId klitem-tr mlo-c r-"]'); // use common class prefix
  // console.log('Carousel length:', carouselItems.length);

  const vanGoghPaintings = []; // array to store extracted data

  for (let i = 0; i < carouselItems.length; i++) { // loop through carousel items
    const carouselItem = carouselItems[i];

    // extract name, extensions, link, and image
    const name = carouselItem.querySelector('a')?.getAttribute('aria-label') || null;
    const extensions = carouselItem.querySelector('.ellip.klmeta');
    const link = carouselItem.querySelector('a')?.getAttribute('href') || null;
    const image = carouselItem.querySelector('img')?.getAttribute('data-key') || null;

    vanGoghPaintings.push({
      'name': name,
      'extensions': extensions ? [extensions.textContent.trim()] : undefined,
      'link': link,
      'image': image
    });
  }

  return vanGoghPaintings;
};

module.exports = extractPaintingsData