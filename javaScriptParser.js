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
    console.log($.html());
} catch (err) {
    console.error('Error:', err);
}
