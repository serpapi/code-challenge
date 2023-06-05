import { load } from 'cheerio';
import { promises as fsPromises } from 'fs';

// async function to retrieve html content from html file
export const retrieveHtml = async (fileName) => {
  try {
    // fsPromises.readFile reads html file async
    const htmlCode = await fsPromises.readFile(`./files/html_files/${fileName}.html`, 'utf-8');
    return htmlCode;
  } catch (err) {
    console.error(err);
    throw err;
  }
};

// async function to write json data to json file
export const writeJsonFile = async (resultsObj, fileName) => {
  try {
    // convert resultArray to a json string
    const arrStringified = JSON.stringify(resultsObj);
    // fsPromises.writeFile writes json data to json file async
    await fsPromises.writeFile(`./files/json_files/${fileName}.json`, arrStringified);
    console.log(`${fileName}.json written successfully`);
  } catch (err) {
    console.error(err);
    throw err;
  }
};

// async function to parse html file results into array and call writeJsonFile function
export const getResults = async (fileName, itemsSelector, nameSelector, extSelector, linkSelector, imageSelector) => {
  try {
    // retrieve the html code from html file
    const htmlCode = await retrieveHtml(fileName);
    // load html code into Cheerio for parsing
    const $ = load(htmlCode);
    // find carousel items
    const carouselItems = $(itemsSelector);
    const resultsArray = [];
    carouselItems.each((i, element) => {
      // parse relevant data from each carousel item and add it to resultsArray
      const elementObj = {
        name: $(element).find(nameSelector).attr('aria-label'),
        extensions: [
          $(element).find(extSelector).text(),
        ],
        link: $(element).find(linkSelector).attr('href'),
        image: $(element).find(imageSelector).attr('src'),
      };
      resultsArray.push(elementObj);
    });
    // wrap resultsArray in an object - not sure if this is really necessary
    const resultsObjKey = fileName === "van-gogh-paintings" ? "artworks" : "hikingSpots";
    const resultsObj = {[resultsObjKey] : resultsArray}
    // write resultsObj to json file
    await writeJsonFile(resultsObj, fileName);
  } catch (err) {
    console.error(err);
    throw err;
  }
};

// call async function to call main functions using await
(async () => {
  try {
    await getResults('van-gogh-paintings', '.MiPcId.klitem-tr', '.klitem', 'div.ellip.klmeta', '.klitem', `.rISBZc.M4dUYb`);
    await getResults('wa-hiking-spots', '.ICcdW', '.srTCxb', '.J1FGbf span:first', '.a-no-hover-decoration', 'img');
    await getResults('ca-hiking-spots', '.ICcdW', '.srTCxb', '.J1FGbf span:first', '.a-no-hover-decoration', 'img');
  } catch (err) {
    console.error(err);
  }
})();