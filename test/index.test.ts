import { getHtmlNodeFromFile, readFile } from "../src";

describe('check that tests are working', () => {
    test('5 equals 5', () => {
        expect(5).toBe(5);
    });
    test('read file is not null', () => {
        const fileString = readFile('./files/van-gogh-paintings.html');
        expect(fileString).not.toBeNull();
    });
    test('parse html should not be null', () => {
        const htmlNode = getHtmlNodeFromFile('./files/van-gogh-paintings.html');
        expect(htmlNode).not.toBeNull();
    });
});
