const express = require('express'); 
const app = express();              
const port = 8081;        

let page = 'van-gogh-paintings.html'; 

app.get('/', (req, res) => {       
    res.sendFile(page, {root: __dirname});   
});

app.listen(port, () => {            
    console.log("Extracting data ..."); 
});

'use strict';

const fs = require('fs');

let expectedJSON = {};
expectedJSON.artworks = [];

var elementsArray, artwork, artworkName, artworkExtension, artworkLink, artworkImage, artworkImageId, artworkImageData; 

parseHTML();

async function parseHTML() {
   fetch('http://127.0.0.1:8081/')
  .then(response => response.text())
  .then(text => {
    getElementsFromHTML(text);
  }); 
}

function getElementsFromHTML(html) {

  // Get all artwork elements.
  elementsArray = [...html.matchAll('<a class="klitem".*?<\/a>')];

  for (i=0; i<elementsArray.length; i++) {
    let index = i + 1;
    console.log("Processing artwork no. " + index);

    // Get artwork name. 
    artworkName = elementsArray[i][0].match('<a class="klitem" aria-label="(.*?)"');
    if (artworkName != null) {
      artworkName = artworkName[1];
    }

    // Get artwork extension. 
    artworkExtension = elementsArray[i][0].match('<div class="ellip klmeta">(.*?)<\/div>');
    if (artworkExtension != null) {
      artworkExtension = [artworkExtension[1]];
    }

    // Get artwork link. 
    artworkLink = elementsArray[i][0].match('href="(.*?)"');
    if (artworkLink != null) {
      artworkLink = artworkLink[1];
      artworkLink = "https://www.google.com" + artworkLink; 
      artworkLink = artworkLink.replace(/&amp;/g, "&");
    }

    // Get artwork image src. 
    // This src is different from the one shown in the `expected-array.json` file
    // and javascript is not executed in the parsed html file. 
    // Therefore, I used the below approach with getting the thumbnails from
    // the javascript part based on image id. 
    artworkImage = elementsArray[i][0].match('<img (.*?)src="(.*?)" data-deferred');
    if (artworkImage != null) {
      artworkImage = artworkImage[2];
    }

    // Get artwork id. 
    artworkImageId = elementsArray[i][0].match('<img (.*?)id="(.*?)"');
    if (artworkImageId != null) {
      artworkImageId = artworkImageId[2];
    }

    // Get base64 jpeg image data. 
    let imageMatch = "(.*?)"+artworkImageId+"(.*?)function(.*?)var s='(.*?)'";
    artworkImageData = html.match(imageMatch); 
    if (artworkImageData != null) {
      artworkImageData = artworkImageData[4];
      artworkImageData = artworkImageData.replace(/\\/g, "").replace(/\\\\/g, "");
    }

    // Push properties to JSON. 
    if (artworkExtension != null) {
      artwork = {
        name: artworkName,
        extensions: [artworkExtension],
        link: artworkLink, 
        image: artworkImageData, 
      }
    } else {
      artwork = {
        name: artworkName,
        link: artworkLink, 
        image: artworkImageData, 
      }
    }
    expectedJSON.artworks.push(artwork);

  }

  // Pass JSON to an actual file. 
  fs.writeFile('expected-array.json', JSON.stringify(expectedJSON), (err) => {
      if (err) throw err;
      console.log('Data written to file expected-array.json');
  });

}