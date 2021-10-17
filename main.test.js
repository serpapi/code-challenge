const run = require('./main.js');
const fs = require('fs');
const url = require('url');
const path = require('path');

const localurl = url.format({
    protocol: 'file',
    slashes: true,
    pathname: path.join(__dirname, 'files/van-gogh-paintings.html')
})

jest.setTimeout(30000);

test('localVanGogh', async () => {
    const json = await run(localurl, 'LocalVanGogh');
    const data = fs.readFileSync(path.join(__dirname, 'expectedJSON/vanGoghOffline.json'),{ encoding: 'utf8' });

    expect(json).toBe(data);
});

test('onlineVanGogh', async () => {
    const json = await run('https://www.google.com/search?q=van+gogh+paintings', 'OnlineVanGogh');

    expect(JSON.parse(json)["Artworks"]).toEqual(
        expect.arrayContaining([
            expect.objectContaining(
                {
                    "name": "The Starry Night",
                    "extensions": [
                        "1889"
                    ],
                },
            )]));
});

test('findTrumpsArtOfTheDeal', async () => {
    const json = await run('https://www.google.com/search?q=trump+books', 'Trump');

    expect(JSON.parse(json)["Books"]).toEqual(
        expect.arrayContaining([
            expect.objectContaining(
                {
                  "name": "Trump: The Art of the Deal",
                  "extensions": [
                    "1987"
                  ],
                }
            )]));
});

test('findJamesBondFilm', async () => {
    const json = await run('https://www.google.com/search?q=james+bond+movies', 'Bond');

    expect(JSON.parse(json)["Movies"]).toEqual(
        expect.arrayContaining([
            expect.objectContaining(
                {
                  "name": "No Time To Die",
                  "extensions": [
                    "2021"
                  ],
                }
            )]));
});

test('AllCarouselItemsHaveLinksAndImages', async () => {
    const json = await run('https://www.google.com/search?q=lil+peep+albums&oq=lil+peep', 'Peep');

    const albums = JSON.parse(json)["Albums"];

    expect(albums.length).toEqual(
        albums.filter(album => {
            return album.image && album.link &&
                album.image !== "null" && album.link.includes('www.google');
        }).length);
});
