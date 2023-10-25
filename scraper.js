import rp from 'request-promise';
import { load } from 'cheerio';

const url = 'https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html';

const requestOptions = {
  uri: url,
  rejectUnauthorized: false, // Ignore SSL certificate errors. When I intially tried scraping the file there seemed to be SSL related errors and this made them go away.
};

rp(requestOptions)
  .then(function (html) {
    const $ = load(html);

    const klitemElements = $('.klitem'); // selecting each of the 'painting' elements

    
    const paintings = []; // an array to store the each painting object

    klitemElements.each(function (i, element) {
      const title = $(element).find('.kltat span').text();
      const date = $(element).find('.ellip.klmeta').text();
      const imageLink = $(element).find('img').attr('data-key'); // first 8 images shown on google SERP
      const imageLinkTwo = $(element).find('img[data-src]').attr('data-src'); // remaining images not shown intially on google SERP
      const href = $(element).find('a').attr('href'); // I can't get this to show up correctly in the output array even though I'm following the logic of the thumbnail links


      // collecting the scraped data into an object
      const painting = {
        title,
        date,
        imageLink,
        imageLinkTwo,
        href,
      };

      paintings.push(painting); // pushing each 'painting' object into the 'paintings' array
    });

    console.log(paintings); 
  })
  .catch(function (err) {
    // Handle error
    console.error('Error:', err);
  });
