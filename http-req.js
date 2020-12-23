const axios = require('axios');
const fs = require('fs');
// const cheerio = require('cheerio');

// Search Ruby books
axios.get("https://www.google.com/search?q=ruby+on+rails+books&sxsrf=ALeKk03a5w5cuxLAg2flUiKqZfonbKE6tw:1608750733705&gbv=2&sei=jZbjX5jBKoertQbArYjgBw",
    { headers: { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36' }  })
    .then(function(res) {
    
    try {
        fs.writeFileSync('./test-html-files/ruby-books.html', res.data); 
        console.log('File Write Ok')      
    } catch (error) {
        console.log("Error writing file") 
    }
});


// Testing Html returned from Url

// axios.get("https://www.google.com/search?q=van+gogh+paintings&sxsrf=ALeKk024Wme_7nvKVdDu9gm0WzZkeMqDBA:1608743081999&gbv=2&sei=qXjjX6atPNvbtAajg5zIDg",
//     { headers: { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36' }  })
//     .then(function(res) {

//     const $ = cheerio.load(res.data);

//     console.log($('.EDblX.DAVP1').html());
// })
// .catch(
//     (error) => {
//         console.log(error);
//     }
// );

