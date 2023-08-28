const { JSDOM } = require('jsdom');
const { expect } = require('chai');
const fs = require('fs');

const extractPaintingsData = require('./paintingsExtraction.js');

describe('extractPaintingsData', () => {
  it('Extracted data should be an array with more than 0 elements in it', () => {
    const content = fs.readFileSync('./van-gogh-paintings.html', 'UTF-8');
    const dom = new JSDOM(content);
    global.document = dom.window.document;

    const vanGoghPaintings = extractPaintingsData();

    expect(vanGoghPaintings).to.be.an('array');
    expect(vanGoghPaintings).to.have.lengthOf.above(0);
  });

  it('Extensions should be an array or undefined', () => {
    const content = fs.readFileSync('./van-gogh-paintings.html', 'UTF-8');
    const dom = new JSDOM(content);
    global.document = dom.window.document;

    const vanGoghPaintings = extractPaintingsData();

    vanGoghPaintings.forEach(painting => {
      expect(painting.extensions).to.satisfy(extension => {
        return Array.isArray(extension) || extension === undefined;
      });
    });
  });

  it('Image should be null if not found', () => {
    const content = fs.readFileSync('./van-gogh-paintings.html', 'UTF-8');
    const dom = new JSDOM(content);
    global.document = dom.window.document;

    const vanGoghPaintings = extractPaintingsData();

    vanGoghPaintings.forEach(painting => {
      if (!painting.image) {
        expect(painting.image).to.equal(null);
      }
    });
  });

  it('Extracted data should be formatted correctly', () => {
    const content = fs.readFileSync('./van-gogh-paintings.html', 'UTF-8');
    const dom = new JSDOM(content);
    global.document = dom.window.document;

    const vanGoghPaintings = extractPaintingsData();

    vanGoghPaintings.forEach(painting => {
      expect(painting).to.have.property('name').that.is.a('string');
      expect(painting).to.have.property('extensions').that.is.an('array').or.is.undefined;
      expect(painting).to.have.property('link').that.is.a('string');
      expect(painting).to.have.property('image').that.is.a('string').or.is.null;
    });
  });
});

