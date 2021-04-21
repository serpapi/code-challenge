
const { HOST_ORIGIN } = require("../common/constants");

const getSerpItemFromCarouselItem = (carouselItem, html) => {
  if (!carouselItem || !html) {
    return null;
  }
  
  const extensionsNode = carouselItem.querySelector('div:nth-child(2) > div:nth-child(2)');
  const href = carouselItem.getAttribute('href');
  const name = carouselItem.getAttribute('aria-label');
  const extension = extensionsNode ? extensionsNode.textContent : null;
  const imageNode = carouselItem.querySelector('img');
  let image = null;
  if (imageNode && imageNode.id) {
    image = getBase64ImageFromId(imageNode.id, html)
  }
  
  return {
    name,
    ...extension && { extensions: [ extension ] },
    link: HOST_ORIGIN + href,
    image
  };
}

const getBase64ImageFromId = (id, html) => {
  if (!id || !html) {
    return null;
  }
  
  const endIdentifier =  html.indexOf(`';var ii=['${id}'`);
  if (endIdentifier < 0) {
    return null;
  }
  const startIdentifier = html.substring(0, endIdentifier).lastIndexOf(` s='`);
  if (startIdentifier < 0) {
    return null;
  }
  
  return html.substring(startIdentifier + 4, endIdentifier).replace(/\\/g, '');
}

module.exports = {
  getSerpItemFromCarouselItem,
  getBase64ImageFromId
}
