import { JSDOM } from "jsdom";

// Fetches webpage contents for scraping.
// @param url the URL to fetch contents from.
// @returns a promise that resolves to a string of the webpage.
export async function getHTML(url) {
  const response = await fetch(url);
  const text = await response.text();
  return text;
}

// Finds the list of artworks from the webpage.
// @param text string of the webpage HTML.
// @returns a nodelist of the artworks.
export function createNodeList(text) {
  // Emulate a browser DOM since Node.js is not a browser environment.
  const dom = new JSDOM(text);

  // Find the carousel element that the artworks are in.
  const carouselContainer = dom.window.document.querySelector(
    "g-scrolling-carousel"
  );

  // Get a list of the artworks inside the carousel. The items are nested three divs in.
  let items = carouselContainer.querySelectorAll("div > div > div");
  return items;
}

// Parses the node list to read and store each artwork's information.
// @param nodeList collection of nodes representing HTML elements.
// @returns an array of objects containing information about an artwork.
export function parseNodeList(nodeList) {
  const artworks = [];

  for (let i = 0; i < nodeList.length; i++) {
    // Initialize object that will be pushed into artworks array.
    const artwork = {};

    // Find the container that has the name and extension(s) of the artwork.
    const textContainer = nodeList[i].querySelector("a > div:last-child");

    // Extract the first div of the textContainer to get the name.
    const text = textContainer.querySelectorAll("div");
    artwork.name = text[0].textContent;

    // Extract the remaining divs of the textContainer to get the extensions.
    artwork.extension = [];
    if (text.length > 1) {
      for (let i = 1; i < text.length; i++) {
        artwork.extension.push(text[i].textContent);
      }
    }

    // Find the anchor element to extract its URL.
    // Then append the URL to the google domain because its only a relative path.
    const linkContainer = nodeList[i].querySelector("a");
    const link = "https://www.google.com" + linkContainer.href;
    artwork.link = link;

    // Find the image element and add its source information to the artwork.
    const imageContainer = nodeList[i].querySelector("img");
    artwork.image = imageContainer.src ? imageContainer.src : null;

    // Add the individual artwork to the list of artworks.
    artworks.push(artwork);
  }

  return artworks;
}
