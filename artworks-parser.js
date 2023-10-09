const { parse } = require("node-html-parser");
const IMAGE_DATA_REGEX =
  /function\(\)\{var s='(data:image\/jpeg;base64,[^']*)';var ii=\['(kximg\d*)'\];_setImagesSrc\(ii,s\);/g;

function getImagesData(htmlString) {
  const matches = {};
  let match;
  while ((match = IMAGE_DATA_REGEX.exec(htmlString))) {
    const base64ImageData = match[1].replace(/\\/g, "");
    const kximgString = match[2];

    matches[kximgString] = base64ImageData;
  }
  return matches;
}

function getArtworks(htmlString) {
  const root = parse(htmlString);

  // make sure we have app bar for artworks
  const bar = root.querySelector(".kappbar .klbar");
  if (!bar) {
    return [];
  }

  // it seems from sample json that we want to only collect artworks, so the following should ensure this.
  // However, there's conflicting instructions mentioning the script should work for any carrousel, so I'm leaving this out for now.
  // const barTitle = bar.parentNode.childNodes[0].querySelector(
  //   '[data-elabel="Artworks"]'
  // );
  // if (!barTitle) {
  //   return [];
  // }

  // get all artwork items
  const images = getImagesData(htmlString);
  const artworkElements = bar.querySelectorAll(".klitem");

  if (!artworkElements || artworkElements.length === 0) {
    return [];
  }

  return artworkElements.map((element) => {
    const title = element.getAttribute("aria-label");
    const url = element.getAttribute("href");
    const extensions = element
      .querySelectorAll(".klmeta")
      .map((meta) => meta.text);

    const imageId = element.querySelector(".klic img").getAttribute("id");
    const elements = {
      name: title,
      link: "https://www.google.com" + url,
      image: images[imageId] ?? null,
    };
    if (extensions.length > 0) {
      elements["extensions"] = extensions;
    }
    return elements;
  });
}

module.exports = { getArtworks };
