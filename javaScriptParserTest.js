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

    // JSON generated file should exist
    it('Verify JSON generated file exists', function () {
        const filePath = 'van-gogh-paintings.json';
        const fileContent = fs.readFileSync(filePath, 'utf8');
        assert.ok(fileContent, 'File exists');
    });

    it('Verify painting named "The Starry Night" exists', function () {
        const filePath = 'van-gogh-paintings.json';
        const fileContent = fs.readFileSync(filePath, 'utf8');
        const paintingNameExists = fileContent.includes('The Starry Night');
        assert.ok(paintingNameExists, 'The Starry Night painting exists');
    });

    it('Verify number of results in JSON file', function () {
        const filePath = 'van-gogh-paintings.json';
        const fileContent = fs.readFileSync(filePath, 'utf8');
        const jsonData = JSON.parse(fileContent);
        assert.strictEqual(jsonData.length, 51, 'There are 51 results in the JSON file');
    });


});
