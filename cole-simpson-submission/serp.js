import * as cheerio from "cheerio";
import axios from "axios";
import fs from "fs";

const readHtmlFromFile = (filePath) => {
    try {
        return fs.readFileSync(filePath, "utf8"); // Read file as a UTF-8 string
    } catch (error) {
        console.error(`❌ Error reading file: ${error.message}`);
        return null;
    }
};


// Fetch the desired URL. The URL must return raw HTML
async function fetchUrl(url) {
    try {
        const response = await axios.get(url, {
        headers: {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
        }
        });
        if (response.status === 200) {
            console.log("Page loaded successfully");
            return response.data;
        }
        else {
            console.error(`Error: Received status code ${response.status}`);
            return null;
        }
    } catch (error) {
        console.error(`Error fetching URL: ${error}`);
        return null;
    }
}

// Fetches raw HTML from a URL, then parses through it and builds the JSON response
const parseHtml = async (url) => {

    let responseData;
    
    // Loads local HTML file
    if (url === "movies") {
        responseData = readHtmlFromFile("./movies.html");
    }
    else if (url === "books") {
        responseData = readHtmlFromFile("./books.html");
    }
    else {
        responseData = await fetchUrl(url);
    }

    if (!responseData) {
        console.error("❌ Failed to load HTML");
        return null;
    }

    const $ = cheerio.load(responseData);
    const selectedTab = $('[role="tab"]').filter((_, el) => $(el).attr('aria-selected') === "true"); // Identifies which tab on the knowledge graph is selected

    // Dives deep into the element to find the text content in the selected tab (used to identify the category in the selected tab)
    const findDeepestTextNode = (element) => {
        let children = $(element).children();

        // If there are no children, extract the text content
        if (children.length === 0) {
            return element;
        }

        // Recursively check each child
        for (let i = 0; i < children.length; i++) {
            let result = findDeepestTextNode(children[i]);
            if (result) return result;
        }

        return null;
    };

    // Finds the element containing the data type and modifies it
    const type = findDeepestTextNode(selectedTab).children[0].data.toLowerCase();

    // Finds the knowledge graph container
    const knowledgeGraph = $('[data-attrid^="kc:"]').first();

    // Identifies all objects in the knowledge graph (movies, artworks, etc.)
    const findAllLinks = (element) => {
        let children = $(element).children();
        let results = [];

        // Check if any child contains an <a> element directly
        children.each((_, el) => {
            if ($(el).find('a').length === 1) { // Checks for length === 1 to make sure each individual object is pushed rather than parent containers
                results.push(el);
            }
        });

        // Recursively search deeper in all children
        children.each((_, el) => {
            results.push(...findAllLinks(el));
        });

        return results;
    };

    // Get all display objects in a knowledge graph
    const kgObjects = findAllLinks(knowledgeGraph);

    // Searches each display object for text information and stores it in an array
    const findAllTextElements = (element) => {
        let results = [];

        // Checks all children of the passed in element for text content
        $(element).children().each((_, child) => {
            const $child = $(child);

            // Check if the element has no children (likely to contain text)
            if ($child.children().length === 0) {
                const textContent = $child.text().trim();
                if (textContent.length > 0) {
                    results.push(textContent); // Only push if it contains text
                }
            } else {
                // Check deeper children
                results.push(...findAllTextElements(child));
            }
        });

        return results;
    };

    // Builds the array of object containing information on the respective display objects
    const objects = kgObjects.map(el => {
        const textElements = findAllTextElements(el);
    
        const name = textElements[0]; // First extracted text element on each display object likely to be the name
        
        // Checks remaining text elements for various bits of information
        const extensions = [];
        for (let i=1; i<textElements.length; i++) {
            extensions.push(textElements[i]);
        }

        // Gets link and image data to finish the object
        return {
            "name": name,
            "extensions": extensions,
            "link": $(el).find('a').attr('href'),
            "image": $(el).find('img').attr('src')
        };
    });

    // return {
    //     [type]: objects
    // }

    return JSON.stringify({
        [type]: objects
    });
};

export default parseHtml;

// Can use these for manual checking of the responses

// const artworks = await parseHtml("https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html");
// console.log("Artworks: ", artworks);

// const movies = await parseHtml("movies");
// console.log("Movies: ", movies);

// const books = await parseHtml("books");
// console.log("Books: ", books);