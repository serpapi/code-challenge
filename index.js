const browser = require('./browser.js');
const scraperController = require('./controller.js');


let browserInstance = browser.startBrowser();
scraperController(browserInstance);