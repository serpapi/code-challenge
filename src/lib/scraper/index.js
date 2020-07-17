const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

const { files } = require('./lib/constants');

const parseName = (element) => {
  return element.attr('aria-label');
};

const parseLink = (element) => {
  return `https://www.google.com${element.attr('href')}`;
};

const parseImage = (element) => {
  return element.find('g-img img').attr('src');
};

const parseExtensions = (element) => {
  const extension = element.find('.klmeta').text();
  return extension ? [extension] : undefined;
};

const parsePainting = (element) => {
  return {
    name: parseName(element),
    extensions: parseExtensions(element) || null,
    link: parseLink(element),
    image: parseImage(element) || null,
  };
};

const parsePaintings = (htmlFilePath) => {
  const $ = cheerio.load(fs.readFileSync(path.resolve(__dirname, htmlFilePath)));

  return $('g-scrolling-carousel')
    .first()
    .find('a')
    .map((index, element) => {
      return parsePainting($(element));
    })
    .get();
};

module.exports = { parsePaintings, files };
