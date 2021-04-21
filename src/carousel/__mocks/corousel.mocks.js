const fs = require('fs');
const { JSDOM } = require('jsdom');

const getMockValidWithCorouselHTML = () => {
  return fs.readFileSync('./files/van-gogh-paintings.html', 'utf-8');
}

const getMockValidHTMLWithoutCarousel = () => {
  return '<!DOCTYPE html><title>x</title>';
}

const getMockInvalidHTML = () => {
  return 'invalid';
}

const getMockCarouselDomItem = () => {
  const validHtmlWithCarousel = getMockValidWithCorouselHTML();
  const validHTMLDom = new JSDOM(validHtmlWithCarousel);
  const listOfCarouselItem =  validHTMLDom.window.document.querySelectorAll('.appbar g-scrolling-carousel a');
  return  listOfCarouselItem[0];
}

module.exports = {
  getMockValidWithCorouselHTML,
  getMockValidHTMLWithoutCarousel,
  getMockInvalidHTML,
  getMockCarouselDomItem
}