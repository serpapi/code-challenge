const fs = require('fs');
const cheerio = require('cheerio');

const extractVanGoghPaintings = () => {
const html = fs.readFileSync('./files/van-gogh-paintings.html', 'utf-8');
const dom = cheerio.load(html);

const artworks = [];

dom('.kltat').each((index, element) => {
  const name = dom(element).text();
  const extensions = [dom('.klmeta').eq(index).text()];
  const link = dom('a.klitem').eq(index).attr('href');
  const image = dom('.klic img').eq(index).attr('src');

  const artwork = {
    name,
    extensions,
    link,
    image,
  };

  artworks.push(artwork);
});

const jsonArtworks = JSON.stringify(artworks, null, 2);

fs.writeFileSync('./files/artworks.json', jsonArtworks);
}

extractVanGoghPaintings();

module.exports = extractVanGoghPaintings;
