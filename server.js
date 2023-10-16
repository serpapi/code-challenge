
// basic express server setup
require('dotenv').config()
const fs = require('fs')
const express = require('express');
const app = express();

// serapi methods
const { config, getJson, getHtml } = require('serpapi');

// params object to avoid duplication
const params = {
    engine: 'google',
    q: 'van gogh paintings',
    api_key: process.env.SERPAPI_API_KEY
}

// use a single (1) GET request to meet requirements
app.get('/', async (req, res) => {


    const getVanGoghPaintingsJson = await getJson(params);
    const getVanGoghPaintingsHtml = await getHtml(params)

    // render html page in repository
    res.send(getVanGoghPaintingsHtml);

    // push data into array
   
   const vanGoghArray = Array.from(getVanGoghPaintingsJson.knowledge_graph.artworks);

    
    const thumbnailsArray = getVanGoghPaintingsJson.inline_images;
    vanGoghArray.push(...thumbnailsArray.map(image => ({
        title: image.title,
        thumbnail: image.thumbnail,
    })))

   //console.log(vanGoghArray)

    // Create a json file with expected array
    const jsonStr = JSON.stringify(vanGoghArray);
    const filePath = 'download.json';
    fs.writeFileSync(filePath, jsonStr);
    res.download(filePath)


    res.end();
})

// Listen on port 3000
app.listen(process.env.PORT, console.log('express is running'))