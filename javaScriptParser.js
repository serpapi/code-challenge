const fs      = require('fs');
const path    = require('path');
const cheerio = require('cheerio');

const filename  = 'van-gogh-paintings.html';
const directory = 'files';

const filePath = path.join(__dirname, directory, filename);

// Check if file exists
fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
        console.error('File does not exist:', err);
        return;
    }
// Check if file is readable
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err);
            return;
        }
    });
});

// Load HTML content into Cheerio
try {
    const htmlContent = fs.readFileSync(filePath, 'utf8');
    const $ = cheerio.load(htmlContent);

    // Loop div with class 'MiPcId klitem-tr' and extractdata
    $('div.MiPcId.klitem-tr').each((index, element) => {

        const paintingName      = $(element).find('div.kltat').text().trim();
        const paintingExtension = $(element).find('div.ellip.klmeta').text().trim();
        const paintingImageUrl  = $(element).find('img').attr('data-src');
        const paintingThumbnail = $(element).find('img').attr('src');

        console.log(
            `Index: ${index + 1}, Painting Name: ${paintingName}, 
        Extension: ${paintingExtension}, Image URL: ${paintingImageUrl}  , Thumbnail: ${paintingThumbnail}`);
    });






} catch (err) {
    console.error('Error:', err);
}


