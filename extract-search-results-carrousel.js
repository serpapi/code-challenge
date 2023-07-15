const fs = require('fs');
const cheerio = require('cheerio');

const extractSearchResults = () => {
const allArtworks = [];

const htmlFiles = [
    './files/pablo-picasso-paintings.html', 
    './files/salvador-dali-paintings.html', 
  ];

htmlFiles.forEach((filePath) => {

  const html = fs.readFileSync(filePath, 'utf-8');

  const dom = cheerio.load(html);

  const artworks = [];

  dom('.KHK6lb').each((index, element) => {
    const name = dom(element).text();
    const extensions = [dom('.cxzHyb').eq(index).text()];
    const link = dom('.iELo6 a').eq(index).attr('href');
    const image = dom('.iELo6 img').eq(index).attr('src');

    const artwork = {
      name,
      extensions,
      link,
      image,
    };

    artworks.push(artwork);
  });

  allArtworks.push(...artworks);
});

const jsonArtworks = JSON.stringify(allArtworks, null, 2);

fs.writeFileSync('./files/all-artworks.json', jsonArtworks, 'utf-8');
}

extractSearchResults()

module.exports = extractSearchResults;
