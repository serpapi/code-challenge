const cheerio = require("cheerio");
const parseScript = require("shift-parser").parseScript;

/*
 * Function to parse the <script> elements from the HTML to extract the lazy-loaded images. This is because the `src` attribute is being dynamically set.
 * The `src` attribute initially contains a 1x1 placeholder pixel / image. I'm not sure if this is the most robust way to extract the images without additional
 * HTTP calls from the AST, but I tried it with several carousels and it works
 *
 * @param {string} id the id of the <img> element that the image is being lazy loaded into
 * @param {object} ast Abstract Syntax Tree representing the parsed script that lazy loads the image into the <img> element referenced by the `id` param
 * @returns {string}
 */
function extractLazyLoadedImageFromAst(id, ast) {
  const lazyLoadingFunctionStatement = ast.statements.find(
    (stmt) =>
      stmt.type === "ExpressionStatement" &&
      (JSON.stringify(stmt.expression?.callee?.body) ?? "").includes(`"${id}"`)
  );

  const imgSrcNode =
    lazyLoadingFunctionStatement?.expression?.callee?.body?.statements?.find(
      (stmt) =>
        stmt.type === "VariableDeclarationStatement" &&
        stmt.declaration?.declarators?.[0]?.init?.type ===
          "LiteralStringExpression" &&
        stmt.declaration?.declarators?.[0]?.init?.value.includes("data:image")
    );

  return imgSrcNode?.declaration?.declarators?.[0]?.init?.value;
}

/**
 * This function extracts the `name` and the `date`
 * Its main assumption is that we can find an html element / tag
 * such that its only text is the date, from which we extract the date
 * Basically this allows us to rule out cases such as `Blade Runner 2049`
 * because this `2049` is a part of the title, and not the date of production, which would actually be `2017` in this case
 * Then, the title is just ANY text that's descended from the <a> tag that is NOT the date of production
 * @param {cheerio.CheerioAPI} $
 * @param {cheerio.Element} aTag
 * @returns {[string, [string] | null]}
 */
function extractNameAndExtensionsFromCarouselItem($, aTag) {
  let extensions = null;

  $(aTag)
    // selector for any html tag that's a child of `aTag`
    .find("*")
    .each((_, block) => {
      const text = $(block).text();
      const yearRegex = /^\d{4}$/g;
      const matchedYear = text.match(yearRegex);
      if (matchedYear) {
        extensions = matchedYear;
      }
    });

  const date = extensions ? extensions[0] : "";

  // the name is then all the text that's not the date found above
  const name = $(aTag).text().split(date).join("").trim();
  return [name, extensions];
}

/**
 * This initially extracts the placeholder image, then calls another function to extract the lazily-loaded image from the <script> tag using an AST.
 * @param {cheerio.CheerioAPI} $
 * @param {cheerio.Element} aTag
 * @returns {string | null}
 */
function extractImageSrcFromATag($, aTag) {
  const imgEls = $(aTag).find("g-img img");

  if (imgEls.length > 1) {
    console.error(
      "Expected a single img element under the `a` tag, instead found a length of",
      imgEls.length,
      $(aTag).attr("href")
    );
  }

  // even if there are multiple images, take the first image, better than not taking an image
  const imgEl = imgEls.eq(0);

  // This is the placeholder, since the images are lazy-loaded
  let image = imgEl.attr("src") || null;

  // we'll use this to find the relevant js function in the page source that lazy-loads this image
  const id = imgEl.attr("id");

  $("script").each((_, element) => {
    const scriptContent = $(element).html();

    if (scriptContent.includes(id)) {
      // this is the script tag that lazy-loads the image for this ID. Parse it into an AST to extract the image
      // doing this to obey the constraint of no additional HTTP calls
      const parsedScript = parseScript(scriptContent);
      image = extractLazyLoadedImageFromAst(id, parsedScript) || image;
    }
  });

  return image;
}

/**
 * Given an HTML string, it returns a JSON array of the elements of the main
 * carousel. If multiple carousels are present on the page, only the one with the appbar class is parsed.
 * @param {string} html
 * @returns {{name: string, extensions?: [string], link: string, image: string | null}[]}
 */
function parseGScrollingCarousel(html) {
  const $ = cheerio.load(html);

  const returnItems = [];

  // find `a` tag elements that are a descendant of g-scrolling-carousel
  // there can be multiple carousels, so find the one that is a descendant of the class `appbar`
  const carouselElems = $(".appbar g-scrolling-carousel a");

  if (carouselElems.length === 0) {
    return [];
  }

  carouselElems.each((_, aTag) => {
    const href = $(aTag).attr("href") || "";

    const [name, extensions] = extractNameAndExtensionsFromCarouselItem(
      $,
      aTag
    );
    const image = extractImageSrcFromATag($, aTag);

    returnItems.push({
      name,
      // some javascript magic to ensure that `extensions` is ONLY present if the production date is present
      // if the production date isn't present there won't be an `extensions` field, so it's an optional field
      ...(extensions && { extensions }),
      // if href is like /search?gl=us&hl=en, just prepend it with the domain to match the expected return format
      link: href.startsWith("/") ? `https://www.google.com${href}` : href,
      image,
    });
  });

  return returnItems;
}

module.exports = {
  parseGScrollingCarousel,
};
