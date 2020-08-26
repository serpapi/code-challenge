const cheerio = require('cheerio');
// const htmlDoc = require('./files/van-gogh-paintings.html');
// const $ = cheerio.load(htmlDoc);
const fs = require('fs');

function paintingParse() {
  fs.readFile('./files/van-gogh-paintings.html', 'utf8', function (err, data) {
    if (err) throw err;

    //load html fill into cheerio
    const $ = cheerio.load(data);

    //narrow down to the paintings div
    // let parentDiv = $('.EDblX');

    //more direct div
    let parentDiv = $('.MiPcId')
    let srcDiv = $('.klic')
    let dataSrc = $('#kximg0')

    //allow mapping over children
    let texts = parentDiv.children();
    //terminal display of html
    // console.log(texts.html());

    //set up for expected array json
    let paintingsJSON = {
      artworks: []
    };

    //mapping over each set to create array.json
    texts.map(function (i, el) {

      let cheerio2 = $(el)
      let img = cheerio2.find('img')
      let image = img[0].attribs.src
      console.log(cheerio2.find('img'))




      if (el.attribs.title === undefined) {
        return;
      }

      //extract date from title
      let titleCount = el.attribs.title.length;
      let year = Number(
        JSON.stringify(el.attribs.title).slice(
          titleCount - 4,
          titleCount
        )
      );

      let painting = {
        name: el.attribs['aria-label'],
        link: 'https://www.google.com' + el.attribs['href'],
        image: null
      }

      //logic to handle if there was no year, and to allow image key value property if it is the first 8 images
      if (i < 8) {
        painting.image = image
      }

      //logic to allow image key value property if it is the first 8 images
      if (year) {
        painting.extensions = [year.toString()]
      }

      paintingsJSON.artworks.push(
        painting
      );
    });


    let file = JSON.stringify(paintingsJSON);
    fs.writeFileSync('test-json.json', file, (err) => {
      if (err) throw err;
      console.log('Data written to file');
    });
  });
}

paintingParse();