const fs = require('fs');
const assert = require('assert');
const cheerio = require('cheerio');

describe('File Tests', function () {

    // HTML file should exist
    it('Verify HTMl file exists', function () {
        const filePath = 'files/van-gogh-paintings.html';
        const fileContent = fs.readFileSync(filePath, 'utf8');
        assert.ok(fileContent, 'File exists');
    });

    // json generated file should exist
    it('Verify JSON generated file exists', function () {
        const filePath = 'van-gogh-paintings.json';
        const fileContent = fs.readFileSync(filePath, 'utf8');
        assert.ok(fileContent, 'File exists');
    });


});
