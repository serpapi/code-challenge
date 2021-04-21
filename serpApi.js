const { getCarousels } = require('./src/carousel/carousel.service');
const fs = require('fs').promises;

if (!process.argv[2]) {
  fs.readFile('./files/van-gogh-paintings.html',  'utf8')
    .then(html => console.log(getCarousels(html)));
  return;
}

if (process.argv[2] && !process.argv[3]) {
  console.log('Invalid input');
  return;
}

switch(process.argv[2]) {
  case '-f':
    fs.readFile(process.argv[3],  'utf8')
      .then(html => console.log(getCarousels(html)))
      .catch(error => console.log(error));
    break;
  case '-s':
    console.log(getCarousels(process.argv[3]))
    break;
  default:
    console.log('Invalid input');
}