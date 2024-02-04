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

export const getFirstCarrouselNodeFromHtmlNode = (node: HTMLElement | null) => {
    if (node === null) return null;
    const rawTagName = node.rawTagName;
    const carouselTagName = 'g-scrolling-carousel';
    if (node.tagName?.toLowerCase() === carouselTagName) return node;
    const children = Array.from(node.childNodes) as HTMLElement[];
    for (let i = 0; i < children.length; i++) {
        const childResult = getFirstCarrouselNodeFromHtmlNode(children[i]) as (HTMLElement | null);
        if (childResult?.tagName.toLowerCase() === carouselTagName) return childResult;
    }
    return null;
};

export const nodeGetTotalLeafCount = (node: HTMLElement) => {
    const children = Array.from(node.childNodes) as HTMLElement[];
    if (children.length === 0) return 1;
    let result = 0;
    for (let i = 0; i < children.length; i++) {

    }
    return result;
};


export const getNodeWithCarrouselItems = (node: HTMLElement) => {
    const possibleItemsListNode = node.childNodes[0].childNodes[0];
    if (possibleItemsListNode.childNodes.length > 1) return possibleItemsListNode as HTMLElement;
    return possibleItemsListNode.childNodes[0] as HTMLElement;
};

export const getItemNodesFromFileWithCarrousel = (fileName: string) => {
    const carrousel = getFirstCarrouselNodeFromHtmlNode(getHtmlNodeFromFile(fileName));
    if (carrousel === null) return [];
    const itemsParent = getNodeWithCarrouselItems(carrousel);
    return itemsParent.childNodes.map(c => c as HTMLElement);
};

const carrouselElementVangogh = getFirstCarrouselNodeFromHtmlNode(getHtmlNodeFromFile('./files/van-gogh-paintings.html'));
const carrouselElementMonet = getFirstCarrouselNodeFromHtmlNode(getHtmlNodeFromFile('./files/monet-paintings.html'));
const carrouselElementLeone = getFirstCarrouselNodeFromHtmlNode(getHtmlNodeFromFile('./files/leone-movies.html'));

const vangoughItems = getItemNodesFromFileWithCarrousel('./files/van-gogh-paintings.html');
const monetItems = getItemNodesFromFileWithCarrousel('./files/monet-paintings.html');
const leoneItems = getItemNodesFromFileWithCarrousel('./files/leone-movies.html');

console.log(getHtmlNodeFromFile('./files/van-gogh-paintings.html'));
