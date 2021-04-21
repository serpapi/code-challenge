const { JSDOM } = require("jsdom");
const { getSerpItemFromCarouselItem } = require("./carousel.presenter");

//try and catch
const getCarousels = (html) => {
  if (!html || typeof html !== 'string') {
    console.log('Invalid input html');
    return [];
  }
  
  // Parse to HTML DOM
  const parsedHtml = new JSDOM(html);
  
  // Extract list of carsousel item from top 'appbar' element
  const listOfCarouselItem =  parsedHtml.window.document.querySelectorAll('.appbar g-scrolling-carousel a');
  if (!listOfCarouselItem || listOfCarouselItem.length < 1) {
    console.log('No carousel item found')
    return [];
  }
  
  let serpItems = []
  listOfCarouselItem.forEach((carouselItem) => {
    serpItems.push(getSerpItemFromCarouselItem(carouselItem, html));
  });
  
  parsedHtml.window.close();
  return serpItems;
}

module.exports = {
  getCarousels
}
