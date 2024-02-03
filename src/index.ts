import fs from 'fs';
import { parse } from 'node-html-parser';

export const readFile = (fileName: string) => {
    try {
        const data = fs.readFileSync(fileName);
        return data.toString();
    } catch (err) {
        console.error(err);
    }
    return null;
};

export const getHtmlNodeFromFile = (fileName: string) => {
    const str = readFile(fileName);
    if (str === null) return null;
    return parse(str);
};

console.log(getHtmlNodeFromFile('./files/van-gogh-paintings.html'));
