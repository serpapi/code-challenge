import { getArtworkFromFile, getHtmlNodeFromFile, readFile } from "../src";

describe('pre tests', () => {
    test('read file is not null', () => {
        const fileString = readFile('./files/van-gogh-paintings.html');
        expect(fileString).not.toBeNull();
    });
    test('parse html should not be null', () => {
        const htmlNode = getHtmlNodeFromFile('./files/van-gogh-paintings.html');
        expect(htmlNode).not.toBeNull();
    });
});

describe('van gogh html parsing', () => {
    const artwork = getArtworkFromFile('./files/van-gogh-paintings.html');
    test('results found', () => {
        expect(artwork.length).toBeGreaterThan(0);
    });
    test('all entries have names', () => artwork.forEach(work => expect(work.name.length).toBeGreaterThan(0)));
    test('all entries have links', () => artwork.forEach(work => expect(work.link.length).toBeGreaterThan(0)));
    test('all entries have images', () => artwork.forEach(work => expect(work.image.length).toBeGreaterThan(0)));
    test('all entries have extensions with date', () => artwork.forEach(work => {
        expect(work.extensions.length).toBe(1);
        let year: number | null = null;
        try {
            year = Number.parseInt(work.extensions[0]);
        } catch (err) {} // do nothing
        expect(year).not.toBeNull;
        expect(typeof year).toBe('number');
    }));
});
