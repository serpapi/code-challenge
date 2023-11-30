const fs = require('fs');
const assert = require('assert');
const cheerio = require('cheerio');

describe('File Tests', function () {

    // HTML file should exist
    it('should check if the file exists', function () {
        const filePath = 'files/van-gogh-paintings.html';
        const fileContent = fs.readFileSync(filePath, 'utf8');
        assert.ok(fileContent, 'File exists');
    });


});
