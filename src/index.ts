import fs from "fs";
import cheerio from "cheerio";

type Painting = {
  name: string;
  link: string;
  image: string | null;
  extensions?: string[];
};

const defaultFilePath = "../files/van-gogh-paintings.html";
const googleSearchPrefix = "https://www.google.com";
const yearRegex = /\([0-9]{4}\)/g;

/**
 * Extracts paintings from HTML content based on selectors.
 * @param {string} html - The HTML content to extract from.
 * @param {string} itemSelector - Selector for painting items.
 * @param {string} nameSelector - Selector for painting names.
 * @param {string} extensionSelector - Selector for painting extensions.
 * @returns {Painting[]} An array of extracted paintings.
 */
function extractPaintingsFromHtml(
  html: string,
  itemSelector: string,
  nameSelector: string,
  extensionSelector: string
): Painting[] {
  const paintingData: Painting[] = [];
  const $ = cheerio.load(html);

  const scripts = $("script");
  const imageIdToBase64Image = extractAndMapImages(scripts.text());

  const paintings = $(itemSelector);
  paintings.each((_, el) => {
    const title = $(el).find(nameSelector).text();
    const searchLink = $(el).attr("href");
    const imageId = $(el).find("img").attr("id") || "";

    if (!title || !searchLink) {
      return;
    }

    const year = $(el).find(extensionSelector).text();
    const titleWithoutYear = removeYearFromTitle(title);

    const painting: Painting = {
      name: titleWithoutYear,
      link: `${googleSearchPrefix}${searchLink}`,
      image: imageIdToBase64Image.get(imageId) ?? null,
    };

    if (year) {
      painting.extensions = [year];
    }

    paintingData.push(painting);
  });

  return paintingData;
}

/**
 * Extracts base64 images from script content and maps them to image IDs.
 * @param {string} scriptContent - The content of the script element.
 * @returns {Map<string, string>} A map of image IDs to base64 images.
 */
function extractAndMapImages(scriptContent: string): Map<string, string> {
  const imageIdToBase64Image: Map<string, string> = new Map();
  const functions = scriptContent.split(/}\s*\)\s*\(\)\s*;/);

  functions.forEach((func) => {
    const iiMatch = func.match(/var ii=\['(.*?)'];/);
    if (iiMatch) {
      const iiArray = iiMatch[1].split(",").map((item) => item.trim());
      if (iiArray.length === 1) {
        const match = func.match(/var s='(.*?)';/);
        if (match) {
          const image = removeBackslashFromBase64Image(match[1]);
          imageIdToBase64Image.set(iiArray[0], image);
        }
      }
    }
  });

  return imageIdToBase64Image;
}

function removeBackslashFromBase64Image(base64Image: string): string {
  return base64Image.replace(/\\/g, "");
}

function removeYearFromTitle(title: string): string {
  return title.replace(yearRegex, "").trim();
}

function savePaintingsToFile(data: Painting[]): void {
  const dataToSave = {
    artworks: data,
  };
  const paintingsJson = JSON.stringify(dataToSave, null, 2);
  fs.writeFileSync("result.json", paintingsJson);
  console.log("File has been created");
}

function isOldHTMLPage(html: string): boolean {
  return !html.includes("kp-wp-tab-overview");
}

export function extractAndSavePaintingsFromHTMLFile(
  htmlFilePath: string = defaultFilePath
): void {
  const html = fs.readFileSync(htmlFilePath, "utf8");

  const oldSelectors = ["a.klitem", "div.kltat", ".klmeta"];
  const newSelectors = [".iELo6>a", ".KHK6lb>.pgNMRc", ".KHK6lb>.cxzHyb"];
  const selectors = isOldHTMLPage(html) ? oldSelectors : newSelectors;

  const paintings = extractPaintingsFromHtml(
    html,
    selectors[0],
    selectors[1],
    selectors[2]
  );
  savePaintingsToFile(paintings);
}

extractAndSavePaintingsFromHTMLFile();
