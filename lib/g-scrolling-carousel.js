const BASE_URL_GOOGLE_SEARCH = "https://www.google.com"; // URL used to resolve the relative path in the carousel links 

export { getCarouselData };

function getCarouselData(document) {
    const TAGNAME_CAROUSEL = "g-scrolling-carousel";
    const carouselElement = document.getElementsByTagName(TAGNAME_CAROUSEL)[0];
    const carouselData = carouselElement ? extractCarouselData(carouselElement) : [];
    return carouselData;
}

function extractCarouselData(carouselElement) {
    const ROLE_VALUE_TAB_LEGACY = "button";
    const ROLE_VALUE_TAB = "tab";
    const getSelectorTab = role => `[role=${role}][title]`;
    const SELECTOR_TAB_LEGACY = getSelectorTab(ROLE_VALUE_TAB_LEGACY); // see the file `samples/van-gogh-paintings.html`
    const SELECTOR_TAB = getSelectorTab(ROLE_VALUE_TAB); // see other files in the `samples` folder
    const legacyCarouselDetected = Boolean(carouselElement.querySelector(SELECTOR_TAB_LEGACY));
    const tabElements = carouselElement.querySelectorAll(legacyCarouselDetected ? SELECTOR_TAB_LEGACY : SELECTOR_TAB);
    return Array.from(tabElements).map(extractTabData);
}

function extractTabData(tabElement) {
    const REGEXP_TAB_TITLE = /^(.+?)(?: \((.+?)\))?$/;
    const TAGNAME_TAB_IMAGE = "img";
    const EMPTY_TAB_IMAGE_URL = null;
    const [, name, extension] = tabElement.title.match(REGEXP_TAB_TITLE);
    const link = new URL(tabElement.getAttribute("href"), BASE_URL_GOOGLE_SEARCH).href;
    const imageElement = tabElement.getElementsByTagName(TAGNAME_TAB_IMAGE)[0];
    const image = imageElement?.src ? imageElement.src : EMPTY_TAB_IMAGE_URL;
    const extensions = extension === undefined ? [] : [extension];
    return { name, extensions, link, image };
}