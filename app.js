const fs = require('fs');
const path =  require('path');
const puppeteer = require('puppeteer');

async function extractData(url, filename) { 
    const browser = await puppeteer.launch();
    const page = await browser.newPage();

    if(url) {    
        await page.goto(url, { waitUntil: 'networkidle2' });
    }
    else {
        await page.goto(`file:${path.join(__dirname, '/files/van-gogh-paintings.html')}`);
    }
    await page.addScriptTag({url: 'https://code.jquery.com/jquery-3.2.1.min.js'});
    
    const data = await page.evaluate( () => {
        
        let artworks = [];

        $('.EDblX').children().each( function(i) {
            let a = $(this);

            if ( a.is('div') ) {
                a = a.find('a');
            }

            let link = a.attr('href');

            const checkLink = /^https:\/\/www.google.com/;

            // Check if link starts with https
            if( link && !checkLink.test(link) ) {
                link  = "https://www.google.com" + link;
            }

            // Check for artworks
            let checkArtworks  = a.find('.kltat').text();
            
            try {
                checkArtworks = decodeURIComponent(escape(checkArtworks));
            }
            catch(err) {
                console.log(err);
            }

            if( checkArtworks ) {
                let extensions = a.find('.ellip').text();
        
                artworks.push({
                    name: checkArtworks         

                });

                if(extensions) {
                    artworks[i]['extensions'] = [extensions]
                }

                if(link) {
                    artworks[i]['link'] = link
                }
            }

            //Check for books
            let checkBooks = a.find('.dAassd').text();

            try {
                checkBooks = decodeURIComponent(escape(checkBooks));
            }
            catch(err) {
                console.log(err);
            }

            if( checkBooks ) {
                let extensions = a.find('.cp7THd').text();
                artworks.push({
                    name: checkBooks  
                });

                if(extensions) {
                    artworks[i]['extensions'] = [extensions]
                }

                if(link) {
                    artworks[i]['link'] = link
                }
            }
        
            // Traverse to 'img' tag and store img-src
            let img = a.find('.BA0A6c > img');
            let imgsrc = img.attr('src');

            // Check if img src is placeholder img
            const checkImgSrc = /\/\/\/\/\/\/\//

            if(imgsrc === undefined || checkImgSrc.test(imgsrc)) {
                imgsrc = null;
            }

            // Img src link to match expected array result
            let checkEnding2Q = /2Q==$/
            if(checkEnding2Q.test(imgsrc)) {
                imgsrc = imgsrc.replace(checkEnding2Q, '2Qx3dx3d');
            }

            let checkEnding9k = /9k=$/
            if(checkEnding9k.test(imgsrc)) {
                imgsrc = imgsrc.replace(checkEnding9k, '9kx3d');
            }

            // Add img src to objects
            if(i < artworks.length) {
                artworks[i]['image'] = imgsrc;
            }

        });
        return artworks;
    });
    
    // console.log(data);
    storeJson(data, filename);
    
    await browser.close();
}

// Save Json data to file
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

let pietMondrian = 'https://www.google.com/search?biw=588&bih=789&ei=o5gEYLyyItLIsAXQqo-YCw&q=piet+mondrian+artworks&oq=piet+mondrian+artworks&gs_lcp=CgZwc3ktYWIQAzIFCAAQyQMyBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeOgcIABDJAxBDOgIIADoICAAQ6gIQjwE6BAgAEEM6BAguEEM6BQgAEJECOgYIABAKEEM6CwguELEDEMcBEKMCOgUIABCxAzoICC4QsQMQgwE6CAgAEMkDEJECOgkIABDJAxAKEEM6BQguELEDOgcILhCxAxBDOgIILjoHCC4QsQMQCjoECC4QCjoECAAQCjoICC4QxwEQrwE6CgguEMcBEK8BEAo6CgguELEDEIMBEAo6CAgAELEDEMkDULGPmQ1Yu7uZDWD2vJkNaAFwAHgBgAH2AogB0BKSAQgxMi4xLjIuMpgBAKABAaoBB2d3cy13aXqwAQrAAQE&sclient=psy-ab&ved=0ahUKEwj8j9eQ4qPuAhVSJKwKHVDVA7MQ4dUDCA0&uact=5';

let rubyOnRails = 'https://www.google.com/search?q=ruby+on+rails+books&oq=ruby+on+rails+books&aqs=chrome..69i57j69i60.4412j0j1&sourceid=chrome&ie=UTF-8';

let javascriptBooks = "https://www.google.com/search?q=javascript+books&oq=javascript+books&aqs=chrome..69i57.3524j0j1&sourceid=chrome&ie=UTF-8";

extractData(null, "van-gogh-paintings");

extractData(pietMondrian, "piet-mondrian-artworks");

extractData(rubyOnRails, "ruby-books");

extractData(javascriptBooks, "javascript-books");