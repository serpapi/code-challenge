import test from 'ava';
import sinon from 'sinon';
import * as cheerio from 'cheerio';
import { promises as fsPromises } from 'fs';
import { retrieveHtml, writeJsonFile, getResults } from './index.js';
// import vanGoghJson from './json_files/van-gogh-paintings.json' assert { type: "json" };

// Mock data for test
const mockHtmlCode = '<html><body><div><div class="elementsClass"><div><div class="nameClass" aria-label="name-1"><div class="linkClass" href="url-1"></div><div class="extClass">string 1</div></div><div><img class="imageClass" src="img-url-1"></div></div></div><div class="elementsClass"><div><div class="nameClass" aria-label="name-2"><div class="linkClass" href="url-2"></div><div class="extClass">string 2</div></div><div><img class="imageClass" src="img-url-2"></div></div></div></div></body></html>';
const mockResults = [
  {
    name: 'name-1',
    extensions: ['string-1'],
    link: 'url-1',
    image: 'img-url-1'
  },
  {
    name: 'name-2',
    extensions: ['string-2'],
    link: 'url-2',
    image: 'img-url-2'
  }
];

// Mock fsPromises.readFile resolves promise of html file being retrieved without error
sinon.stub(fsPromises, 'readFile').resolves(mockHtmlCode);

// Mock fsPromises.writeFile resolves promise of file (json) being written without error
const writeFileStub = sinon.stub(fsPromises, 'writeFile').resolves();

// Stub Cheerio's load method - resolves loading of Cheerio
sinon.stub(cheerio.load);

// Test for retrieveHtml function
test('retrieveHtml should read and return HTML content from a file', async (t) => {
  const fileName = 'test-file';
  const htmlCode = await retrieveHtml(fileName);
  // t.is(actual, expected, message?) Asserts that actual is the same as expected
  t.is(htmlCode, mockHtmlCode, 'Returned HTML code should match mockHtmlCode');
  t.true(fsPromises.readFile.calledOnceWith(`./files/html_files/${fileName}.html`, 'utf-8'), 'fsPromises.readFile should be called with correct arguments');
});

// Test for writeJsonFile function
test('writeJsonFile should write the JSON data to a file', async (t) => {
  const fileName = 'test-file';
  const resultsObj = { results: mockResults };
  await writeJsonFile(resultsObj, fileName);
  // t.is(resultsObj, mockResults, 'written json obj should match mockResultsObj');
  t.true(writeFileStub.calledOnceWith(`./files/json_files/${fileName}.json`, JSON.stringify(resultsObj)), 'fsPromises.writeFile should be called with the correct arguments');
});

// Test for getResults function
test('getResults should parse html file content and pass results to the writeJsonFile function', async (t) => {
  // Mock Cheerio's methods and data
  const mockCheerio = { each: sinon.stub() };
  cheerio.load(mockCheerio);

  await getResults('test-file', 'elementsClass', 'nameClass', 'extClass', 'linkClass', 'imageClass');

  t.true(cheerio.load(mockHtmlCode), 'Cheerio should be called with the correct HTML code');
  t.true(mockCheerio.each.calledOnce, 'Cheerio.each should be called');
  t.true(writeFileStub.calledOnce, 'writeJsonFile should be called once');
});


// test.todo('collection object has array'), t => {
//   t.true(Array.isArray(vanGoghJson["artworks"]), 'Imported json object should be an array');
// }
