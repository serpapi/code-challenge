const axios = require('axios')
const cheerio = require('cheerio')
const express = require('express')
const PORT = 8000

const app = express()
const url = 'https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html'

axios(url)
    .then(response => {
        const html = response.data;
        const $ = cheerio.load(html);
        const artworks = [];

        $(`.MiPcId`).each(function(){
            const name = $(this).find('.kltat').text();
            const extensions = $(this).find('.ellip.klmeta').text(); 
            const link = $(this).find('a').attr('href');
            const imageElement = $(this).find('.BA0A6c img');
            const image = imageElement.attr('data-key') || imageElement.attr('data-src');
            artworks.push({
                name,
                extensions,
                link,
                image
            })
        } )
        console.log(artworks)
    }).catch(err => console.log(err))

app.listen(PORT, () => console.log(`server running on PORT ${PORT}`))