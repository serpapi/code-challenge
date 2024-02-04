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

export const getNodeWithCarouselItems = (node: HTMLElement) => {
    const possibleItemsListNode = node.childNodes[0].childNodes[0];
    if (possibleItemsListNode.childNodes.length > 1) return possibleItemsListNode as HTMLElement;
    return possibleItemsListNode.childNodes[0] as HTMLElement;
};

export const getItemNodesFromFileWithCarousel = (fileName: string) => {
    const root = getHtmlNodeFromFile(fileName);
    if (root === null) return [];
    const carousel = root.querySelector('g-scrolling-carousel');
    if (carousel === null) return [];
    const itemsParent = getNodeWithCarouselItems(carousel);
    return itemsParent.childNodes.map(c => c as HTMLElement);
};

interface ArtworkResult {
    name: string,
    extensions?: string[],
    link: string,
    image: string | null,
}

export const getArtworkFromNodes = (carouselItems: HTMLElement[]) => {
    return carouselItems.map(i => {
        const result: ArtworkResult = {
            name: '',
            link: 'https://www.google.com', // allow addition of google domain to link since img tag links use local domain
            image: null,
        };
        const anchor = i.querySelector('a');
        if (anchor !== null) {
            result.name = anchor.attributes['aria-label'];
            const extensions = anchor.querySelectorAll('.klmeta').map(e => e.innerText);
            if (extensions.length > 0) result.extensions = extensions;
            result.link += anchor.attributes['href'];
            const image = anchor.querySelector('img')?.attributes['src'];
            if (image !== undefined) result.image = image;
        }
        return result;
    });
};

/**
 * Given an html file of a google search result for an artist, returns an array
 * of information about each painting in the carousel element of the page.
 * 
 * @param fileName 
 * @returns 
 */
export const getArtworkFromFile = (fileName: string) => {
    const items = getItemNodesFromFileWithCarousel(fileName);
    return getArtworkFromNodes(items);
};
