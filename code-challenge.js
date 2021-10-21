const puppeteer = require('puppeteer');

const fetchData = async (filename) => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(filename);

    let mainKey = await page.$eval('#extabar > div > div > div > div > div > div > span:last-child', e => e.innerText);
    // Normalize main key value
    mainKey = mainKey.toLowerCase().replace(' ', '-');

    const carouselElements  = await page.$$('#appbar g-scrolling-carousel a');

    const cardData = {
        [mainKey]: []
    }

    for (card of carouselElements) {
        // Since puppeteer is running locally, it adds the base url file:///
        // make sure it points to google.com in the output
        const link = await (await card.getProperty('href')).evaluate(h => h.replace('file:///', 'https://www.google.com/'))

        //Interesting data is contained within three levels of divs inside the
        //card
        const containers = await card.$$('#appbar g-scrolling-carousel a > div > div > div');
        if (containers.length < 3) {
            continue;
        }

        const imageWrapper = containers[1];
        const textWrapper = containers[2];

        const imageSrc = await imageWrapper.$eval('img', img => img.getAttribute('src'));


        // Title and subtitle can be found two levels deeper
        const textContainers = await textWrapper.$$('#appbar g-scrolling-carousel a > div > div > div > div > div')

        // The last element will always be the subtitle
        const subtitleContainer = textContainers.pop();
        const subtitle = await subtitleContainer.evaluate(c => c.innerText)

        // The title can have one or more text elements
        let title = '';
        for (container of textContainers) {
            title += ' ' + await container.evaluate(c => c.innerText);
        }

        cardData[mainKey].push({
            name: title.trim(),
            extensions: [ subtitle ],
            link: link,
            image: imageSrc
        });

    }

    browser.close();
    return cardData
}

module.exports = fetchData;

