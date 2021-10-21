const fetchData = require('./code-challenge');
const resolve = require('path').resolve;

//const filepath = resolve('./files/lord-of-the-rings-cast.html');
//const filepath = resolve('./files/pixar-movies.html');

const filepath = resolve('./files/van-gogh-paintings-2.html');
fetchData(`file://${filepath}`).then(
    data => console.log(JSON.stringify(data, undefined, 2)));


