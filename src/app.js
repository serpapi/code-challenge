const { parsePaintings, files } = require('./lib/scraper');

const vanGoghPaintings = parsePaintings(files.vanGogh);
console.log('vanGoghPaintings: ',vanGoghPaintings);

const museumsInEgypt = parsePaintings(files.museumsInEgypt);
console.log('museumsInEgypt: ', museumsInEgypt);

const claudeMonetPaintings = parsePaintings(files.claudeMonet);
console.log('claudeMonetPaintings: ', claudeMonetPaintings);
