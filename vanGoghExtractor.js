//Trial 1 - jsdom------------------------------------------------------------------------
const fs = require('fs');
const jsdom = require('jsdom');
const { JSDOM } = jsdom;

function extractPaintings() {
  try {
    const html = fs.readFileSync('files/van-gogh-paintings.html', 'utf-8');
    const dom = new JSDOM(html);
    const document = dom.window.document;
    const paintings = [];

    const searchResults = document.querySelectorAll('.klitem');
    searchResults.forEach(result => {
      const title = result.querySelector('.kltat')?.textContent;
      const date = result.querySelector('.ellip.klmeta')?.textContent;
      const link = result.href;
      const thumbnail = result.querySelector('img.rISBZc.M4dUYb')?.src;

      if (title && date && link && thumbnail) {
        paintings.push({
          title,
          date,
          link,
          thumbnail,
        });
      }
    });

    console.log(paintings);
  } catch (error) {
    console.error('An error occurred:', error);
  }
}

extractPaintings();

//Trial 2 - cheerio------------------------------------------------------------------------

// const fs = require('fs');
// const cheerio = require('cheerio');
// const html = fs.readFileSync('files/van-gogh-paintings.html', 'utf-8');
// const $ = cheerio.load(html);

// const paintings = [];

// $('.klitem').each((index, element) => {
//   const title = $(element).find('.kltat').text();
//   const date = $(element).find('.ellip.klmeta').text();

//   const link = $(element).find('a.klitem').attr('href');

//   const thumbnail = $(element).find('img.rISBZc.M4dUYb').attr('src');

//   paintings.push({
//     title,
//     date,
//     link,
//     thumbnail,
//   });
// });

// console.log(paintings);