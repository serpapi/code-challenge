import * as cheerio from "cheerio";
import { hexToAscii } from "./utils";

export type GoogleCarouselItem = {
  name: string;
  extensions: string[];
  link: string;
  image: string | null;
};

export class GoogleCarouselScraper {
  public $: cheerio.CheerioAPI;

  constructor(public html: string) {
    this.html = html;
    this.$ = cheerio.load(html);
  }

  extractItemsFromHTML(): GoogleCarouselItem[] {
    // `a.klitem-tr` exists for newer carousels
    // `a.klitem` exists for the example van gogh html
    const items = this.$("a.klitem-tr, a.klitem")
      .map((_, element) => {
        const name = this.getName(element);
        return {
          name,
          extensions: this.getExtensions(element, name),
          link: this.getLink(element),
          image: this.getImage(element),
        };
      })
      .get();
    return items;
  }

  private getName(element: cheerio.Element): string {
    return element.attribs["aria-label"];
  }

  /**
   * Based on the title attribute of the element, extracts out the extensions
   * by getting the text that trails the name of the current item.
   *
   * Preconditions:
   * - Trailing text is surrounded by one character, e.g. brackets: '(' & ')'
   *
   * E.g. `title`: "The Starry Night (1889)", `name`: "The Starry Night" -> 1889
   *
   * @param element
   * @param name
   * @returns array of extensions
   */
  private getExtensions(element: cheerio.Element, name: string): string[] {
    const titleAttr = element.attribs.title;
    const titleHasName = titleAttr.indexOf(name) !== -1;
    if (titleHasName) {
      const metaWithBrackets = titleAttr.slice(name.length).trim();
      const meta = metaWithBrackets.slice(1, -1);
      return [meta];
    }
    return [];
  }

  private getLink(element: cheerio.Element): string {
    const prefix = "https://www.google.com";
    const href = element.attribs.href;
    if (href.startsWith(prefix)) {
      // In the odd case that the href already contains the prefix,
      // don't incorrectly append the prefix.
      return href;
    } else {
      return `${prefix}${href}`;
    }
  }

  /**
   * Google relies on JavaScript to incrementally populate the image sources.
   * 1. The first few items have the full html with an `img` tag containing a placeholder img.
   *    On load, JS is used to replace the placeholder image src with the actual base64 image.
   * 3. For the remaining items, only the `a` tag exists in the html. On load, JS is used
   *    to populate the innerHtml and the corresponding `img` tag contains an image link instead.
   *
   * This method searches the JavaScript to extract out the corresponding image URIs.
   *
   * @param element
   * @returns image URI or null if it doesn't exist
   */
  private getImage(element: cheerio.Element): string | null {
    const imageId = this.$(element).find("img").attr("id");
    if (imageId) {
      return this.extractImageUriUsingImageId(imageId);
    } else if (element.attribs.id) {
      return this.extractImageUriUsingElementId(element.attribs.id);
    } else {
      return null;
    }
  }

  /**
   * Extracts image URI by using the `img` tag's id.
   *
   * The corresponding image URI can be found by looking for the following snippet:
   * ```
   * (function () {
   *  var s = <image URI>
   *  var ii = [<image id>];
   *  _setImagesSrc(ii, s);
   * })();
   *
   * Preconditions:
   * - JavaScript is defined after the definition of the carousel
   * - image URI (i.e. data:image...) is defined before the image ID
   * - base64 image sources
   *
   * @param imageId
   * @returns
   */
  private extractImageUriUsingImageId(imageId: string): string | null {
    // Corresponds to the definition found in the JavaScript code
    const idxOfImageId = this.html.lastIndexOf(`'${imageId}'`);
    if (idxOfImageId === -1) {
      // Implies there's no corresponding image id in the JavaScript code, and so no image
      return null;
    }

    // The target image URI is found before the image id definition
    const targetSearchHtml = this.html.slice(0, idxOfImageId);
    const imageUri = targetSearchHtml
      .slice(targetSearchHtml.lastIndexOf("data:image")) // Narrow the search
      .match(/(data:image.*?)'/)?.[1]; // Get the first capturing group

    // TODO: figure out a better way to decode the URIs, i.e. `\x3d` -> `=`
    return imageUri ? imageUri.replace(/\\/g, "") : null;
  }

  /**
   * Extracts image URI by using the element's (`a` tag) id.
   *
   * The corresponding image URI can be found by looking for the following snippet:
   * ```
   * window.jsl.dh(
   *   <element id>,
   *   <innerHtml that contains the image URI>
   * );
   * ```
   *
   * Preconditions:
   * - image URI is set via the `data-src` attribute
   *
   * @param elementId
   * @returns
   */
  private extractImageUriUsingElementId(elementId: string): string | null {
    const targetInnerHtml = this.html.match(`'${elementId}','(.*?)'`)?.[1];
    if (targetInnerHtml) {
      const parsedInnerHtml = cheerio.load(hexToAscii(targetInnerHtml));
      const imageUri = parsedInnerHtml("img").attr("data-src");
      return imageUri ?? null;
    }
    return null;
  }
}
