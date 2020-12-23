const fs = require('fs');
const path =  require('path');
const cheerio = require('cheerio');

let artworks;

// Parse Paintings.html
const paintings = path.join(__dirname, './files/van-gogh-paintings.html');
const paintingsHtml = cheerio.load(fs.readFileSync(paintings));

// console.log(paintingsHtml('.EDblX').html());

// Parse Books.html
const books = path.join(__dirname, './test-html-files/ruby-books.html');
const booksHtml = cheerio.load(fs.readFileSync(books));

function extractData($) {
    artworks = [];
    // Iterate through all 'a' tags in 'div'
    $($('.EDblX').children()).each( (i, a) => {
        let aToHtml;
        let name;
        let date;
        let imgsrc = "";

        // Check if child is 'a'
        if( $($(a).html()).is('a') ) {
            aToHtml = $(a).html();
        }

        let link = "https://www.google.com/" + $(aToHtml).attr('href');  // Link stored

        let elemInAtag = $($(a).children()[0]); // First child of 'a'
        
        // If child of 'a' is a 'div' 
        if( $($(elemInAtag).html()).is('div') ) {

            name = $(elemInAtag.find('.kltat')).text();

            date = $(elemInAtag.find('.ellip')).text();
        }

        // Push values to array
        if(name) {
            artworks.push({
                name,
                extensions: date,
                link,
            })
        }

        // Traverse to 'img' tag and store img-src
        if( $($(elemInAtag).html()).is('div') ) {

            let gimg = elemInAtag.find('.klic');

            let img = gimg.children().html();
    
            imgsrc = $(img).attr('src');
        }

        if(imgsrc === undefined) {
            imgsrc = null;
        }

        // Add img src to objects
        if(i < artworks.length) {
            artworks[i]['image'] = imgsrc;
        }
    });
}

function storeJson(artworks, filename) {
    let resultObj = {
        artworks
    }

    let data = JSON.stringify(resultObj, null, 2);

    try {
        fs.writeFileSync(`./final-results/${filename}.json`, data);
        console.log('Json file saved!');
    } catch (error) {
        console.log('Could not write file');
    }
}

extractData(paintingsHtml);
storeJson(artworks, "van-gogh-paintings");

extractData(booksHtml);
storeJson(artworks, "ruby-books");



