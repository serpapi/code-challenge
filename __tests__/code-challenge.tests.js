const resolve = require('path').resolve;
const fetchData = require('../code-challenge.js');


describe('Movie Cast Search Results',  () =>{
    it('Should return "cast" as the top level key', async () => {
        const filepath = resolve('./files/lord-of-the-rings-cast.html');
        const data = await fetchData(`file://${filepath}`);
        expect(Object.keys(data)).toEqual(['cast']);
    });
});

describe('Stuido Movies Search Results', () =>{
    it('Should return "films-produced" as the top level key', async () => {
        const filepath = resolve('./files/pixar-movies.html');
        const data = await fetchData(`file://${filepath}`);
        expect(Object.keys(data)).toEqual(['films-produced']);
    });
});

describe('Artist Artworks Search Results',  () =>{
    let data;

    beforeAll(async () => {
        const filepath = resolve('./files/van-gogh-paintings-2.html');
        data = await fetchData(`file://${filepath}`);
    })

    it('Should return "artworks" as the top level key', async () => {
        expect(Object.keys(data)).toEqual(['artworks']);
    });

    test('Artworks should be an array of objects', () => {
        expect(Array.isArray(data.artworks)).toBe(true);
        expect(typeof data.artworks[0]).toEqual('object');
    })

    test('Each result object should contain name, link, image, and, extensions attributes', () => {
        for (result of data.artworks) {
            expect(result.hasOwnProperty('name')).toBe(true)
            expect(result.hasOwnProperty('link')).toBe(true)
            expect(result.hasOwnProperty('image')).toBe(true)
            expect(result.hasOwnProperty('extensions')).toBe(true)
        }
    })

    test('The extensions attribute must be a non empty array for all elements', () => {
        for (result of data.artworks) {
            expect(Array.isArray(result.extensions)).toBe(true);
            expect(result.extensions.length).toBeGreaterThan(0);
        }
    })

    test('The name attribute must be a non empty string', () => {
        for (result of data.artworks) {
            expect(typeof result.name).toEqual('string')
            expect(result.name).toBeTruthy();
        }
    })

    test('The link attribute must be a non empty string', () => {
        for (result of data.artworks) {
            expect(typeof result.link).toEqual('string')
            expect(result.link).toBeTruthy();
        }
    })
});

