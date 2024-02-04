import fs from 'fs';
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
    test('all entries have images, if defined', () => artwork.forEach(work => {
        if (work.image !== null) expect(work.image.length).toBeGreaterThan(0);
    }));
});

describe('compare to expected array', () => {
    const found = getArtworkFromFile('./files/van-gogh-paintings.html');
    const expected = JSON.parse(fs.readFileSync('./files/expected-array.json').toString()) as Array<any>;
    test('same size', () => expect(found.length).toBe(expected.length));
    test('same names', () => {
        for (let i = 0; i < found.length; i++) {
            expect(found[i].name).toBe(expected[i].name);
        }
    });
    test('same links', () => {
        for (let i = 0; i < found.length; i++) {
            expect(found[i].link).toBe(expected[i].link);
        }
    });
    test('same extensions', () => {
        for (let i = 0; i < found.length; i++) {
            expect(found[i].extensions).toEqual(expected[i].extensions);
        }
    });
    test('same images', () => {
        for (let i = 0; i < found.length; i++) {
            expect(found[i].image).toEqual(expected[i].image);
        }
    });
    test('same array', () => {
        expect(found).toEqual(expected);
    });
});
