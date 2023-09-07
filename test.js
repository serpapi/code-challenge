const { expect } = require('chai');
const fs = require('fs');
const { JSDOM } = require('jsdom');
const extractedData = require('./extract.js');



describe('extractedData', () => {

    it('Results data should be an array with at least 1 element', () => {
        const html = fs.readFileSync('./van-gogh-paintings.html', 'utf-8');
        const dom = new JSDOM(html);
        global.document = dom.window.document;
        const results = extractedData();
        expect(results).to.be.an('array');
        expect(results).to.have.lengthOf.above(0);
    });

    it('Each result should return a name with type string', () => {
        const html = fs.readFileSync('./van-gogh-paintings.html', 'utf-8');
        const dom = new JSDOM(html);
        global.document = dom.window.document;
        const results = extractedData();
        results.forEach(item => {
            expect(item.name).to.be.a('string');
        });
    });

    it('Each result should return either an array or have a null value for extensions', () => {
        const html = fs.readFileSync('./van-gogh-paintings.html', 'utf-8');
        const dom = new JSDOM(html);
        global.document = dom.window.document;
        const results = extractedData();
        results.forEach(item => {
            if(!item.extensions) { expect(item).to.equal(null) }
            else expect(item).to.have.property('extensions').that.is.an('array')
        });
    });

    it('Each result should return a link with type string', () => {
        const html = fs.readFileSync('./van-gogh-paintings.html', 'utf-8');
        const dom = new JSDOM(html);
        global.document = dom.window.document;
        const results = extractedData();
        results.forEach(item => {
            expect(item.link).to.be.a('string');
        });
    });

    it('Each result should return a string for the thumbnail image, or null if there is none', () => {
        const html = fs.readFileSync('./van-gogh-paintings.html', 'utf-8');
        const dom = new JSDOM(html);
        global.document = dom.window.document;
        const results = extractedData();
        results.forEach(item => {
            if(!item.thumbnail) { expect(item).to.have.property('thumbnail').that.is.null }
            else expect(item.thumbnail).to.be.a('string');
        });
    });
});