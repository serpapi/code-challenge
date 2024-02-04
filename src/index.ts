import fs from 'fs';
import { parse, HTMLElement } from 'node-html-parser';

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

export const getCarrouselNodeFromHtmlNode = (node: HTMLElement | null) => {
    if (node === null) return null;
    const rawTagName = node.rawTagName;
    const carouselTagName = 'g-scrolling-carousel';
    if (node.tagName?.toLowerCase() === carouselTagName) return node;
    const childrenArray = Array.from(node.childNodes) as HTMLElement[];
    for (let i = 0; i < childrenArray.length; i++) {
        const childResult = getCarrouselNodeFromHtmlNode(childrenArray[i]) as (HTMLElement | null);
        if (childResult?.tagName.toLowerCase() === carouselTagName) return childResult;
    }
    return null;
};

const root = getHtmlNodeFromFile('./files/van-gogh-paintings.html');
const carrouselElement = getCarrouselNodeFromHtmlNode(root);
console.log(getHtmlNodeFromFile('./files/van-gogh-paintings.html'));
