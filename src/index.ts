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

export const getNodeWithCarrouselItems = (node: HTMLElement) => {
    const possibleItemsListNode = node.childNodes[0].childNodes[0];
    if (possibleItemsListNode.childNodes.length > 1) return possibleItemsListNode as HTMLElement;
    return possibleItemsListNode.childNodes[0] as HTMLElement;
};

export const getItemNodesFromFileWithCarrousel = (fileName: string) => {
    const root = getHtmlNodeFromFile(fileName);
    if (root === null) return [];
    const carrousel = root.querySelector('g-scrolling-carousel');
    if (carrousel === null) return [];
    const itemsParent = getNodeWithCarrouselItems(carrousel);
    return itemsParent.childNodes.map(c => c as HTMLElement);
};

export const getArtworkFromNodes = (carrouselItems: HTMLElement[]) => {
    return carrouselItems.map(i => {
        const name = (i.childNodes[0] as HTMLElement).attributes['aria-label'];
        //const extensions = i.childNodes[]
    });
};

const vangoghItems = getItemNodesFromFileWithCarrousel('./files/van-gogh-paintings.html');
const leoneItems = getItemNodesFromFileWithCarrousel('./files/leone-movies.html');

console.log(getHtmlNodeFromFile('./files/van-gogh-paintings.html'));
