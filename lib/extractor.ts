import type {CheerioAPI} from "cheerio";
import * as cheerio from 'cheerio';
import {readFile} from "node:fs/promises";

export type Artwork = {
  name: string;
  /**
   * Extra information about the year, only the year right now.
   */
  extensions?: string[];
  /**
   * URL for the search page for this artwork.
   */
  link: string;
  /**
   * Base64 encoded image or URL to the image of the artwork.
   */
  image: string;
}

// Relevant script tags end with this i.e. statement that sets the src of the lazy loaded images.
const SCRIPT_MARKER = "_setImagesSrc(ii,s";

const IMAGE_DATA_REGEX = new RegExp(/var s='(.*?)';/);
const IMAGE_ID_REGEX = new RegExp(/var ii=\['(.*?)'];/);

/**
 * Google serp has images that are lazily rendered, their data is stored in
 * variables in the script tags in base64 encoding. The tags contain ids for
 * their respective images. At runtime these scripts replace the src attribute
 * of their images with the base64 encoded data. This function go to all of
 * these script tags and collects the image ids and their base64 encoded data.
 * Script tags look like this (prettified):
 * ```js
 * (function() {
 *   var s = 'image data encoded in base64';
 *   var ii = ['image-id'];
 *   var r = ''; // may be omitted
 *   _setImageSrc(ii, s, r); // 'r' may be omitted
 * })();
 * ```
 * @param $ - Cheerio object containing the parsed HTML of the Google search results page.
 * @return A map where keys are image IDs and values are base64 encoded image data.
 */
function collectLazyImages($: CheerioAPI): Map<string, string> {
  const lazyImages = new Map<string, string>();

  $('script').each((_, script) => {
    const scriptContent = $(script).html();
    if (!scriptContent) return;

    if (!scriptContent.includes(SCRIPT_MARKER)) {
      // Ignore irrelevant script tags that do not contain image data
      return;
    }

    const idMatch = scriptContent.match(IMAGE_ID_REGEX);
    if (!idMatch || !idMatch[1] || idMatch[1].length === 0) {
      return;
    }
    const imageId = idMatch[1];

    // Extract the base64 encoded image data from the script content
    const dataMatch = scriptContent.match(IMAGE_DATA_REGEX);
    if (!dataMatch || !dataMatch[1] || dataMatch[1].length === 0) {
      console.warn(`No image data found for image ID: ${imageId}`);
      return;
    }
    // Un-escape the padding '=' characters in the base64 string from '\\x3d' to '='
    const unescapedImageData = dataMatch[1].replaceAll('\\x3d', '=');
    lazyImages.set(imageId, unescapedImageData);
  })

  return lazyImages;
}

// CSS selectors for extracting artworks from the Google knowledge panel.

const ARTWORK_CONTAINER_ANCHOR_SELECTOR = 'div.iELo6 > a';
const ARTWORK_NAME_SELECTOR = 'div.pgNMRc';
const ARTWORK_YEAR_SELECTOR = 'div.cxzHyb';
const ARTWORK_IMAGE_SELECTOR = 'img.taFZJe';

const GOOGLE_BASE_URL = 'https://www.google.com';


/**
 * Extracts artworks from the artwork knowledge panel in a Google search results page.
 * Structure:
 * ```html
 * <div class="iELo6">
 *   <a href="{relativeURL}">
 *     <img
 *             id="for images with lazy rendering"
 *             class="taFZJe"
 *             src="base64 placeholder"
 *             data-src="remote url for image below the fold" alt="{name}"
 *             data-deferred="1 - for images with lazy rendering"
 *     // {...other attributes}
 *     />
 *     <div class="KHK6lb">
 *       <div class="pgNMRc">{name}</div>
 *       <!-- optional year -->
 *       <div class="cxzHyb">{year}</div>
 *     </div>
 *   </a>
 * </div>
 * ```
 * @param pageHtml - The HTML content of the Google search results page containing the knowledge panel.
 * @return A promise that resolves to an array of artworks extracted from the knowledge panel.
 * @throws Error if the HTML cannot be parsed or if the expected structure is not found.
 */
export async function extractArtworksFromKnowledgePanel(pageHtml: string): Promise<Artwork[]> {
  const $ = cheerio.load(pageHtml);
  const lazyImages = collectLazyImages($);
  const artworks: Artwork[] = [];

  $(ARTWORK_CONTAINER_ANCHOR_SELECTOR).each(
    (_, element) => {
      const $element = $(element);

      const name = $element.find(ARTWORK_NAME_SELECTOR).text().trim();
      const year = $element.find(ARTWORK_YEAR_SELECTOR).text().trim();
      const href = $element.attr('href');

      const imageElement = $element.find(ARTWORK_IMAGE_SELECTOR);
      // Visible artworks only have a src attribute with the base64 encoded
      // image. Hidden artworks in the truncated part of the knowledge panel
      // have a data-src attribute with a remote URL that is fetched and
      // displayed as base64 when the user expands the knowledge panel. We get
      // the remote url from data-src if it exists, otherwise we use the base64
      // encoded image from the src attribute.
      const image = lazyImages.get(imageElement.attr('id') || '') || imageElement.attr('data-src');

      if (!name || !href || !image) {
        console.warn(`Artwork element is missing required fields: name='${name}', href='${href}', image='${image}'`);
        return;
      }

      // Normalize relative image search URLs to absolute URLs
      const link = new URL(href, GOOGLE_BASE_URL).href;

      const extensions = year ? [year] : undefined;

      artworks.push({
        name,
        extensions,
        link,
        image
      });
    }
  )

  return artworks;
}


/**
 * @param serpPath - The path to the Google search results page html file.
 * @return A promise that resolves to an array of artworks extracted from the knowledge panel.
 * @throws Error if the file cannot be read or parsed.
 */
export async function extractArtworksFromSERPFile(serpPath: string): Promise<Artwork[]> {
  const html = await readFile(serpPath, 'utf-8');
  return extractArtworksFromKnowledgePanel(html);
}
