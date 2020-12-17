const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

const PARSE_URL1 = './files/van-gogh-paintings.html';
const PARSE_URL2 = './files/van-gogh-paintings-new.html';
const PARSE_URL3 = './files/michelangelo-paintings.html';
const PARSE_URL4 = './files/aivazovsky-paintings.html';
const PARSE_URL5 = './files/jason-statham-movies.html';

let $;

function parseHtml(url) {
    return new Promise((resolve, reject) => {
        fs.readFile(url, 'utf-8', (err, content) => {
            if (err) {
                reject(err);
            }

            $ = cheerio.load(content);

            const arrayName = $('.kxbc[jsaction="llc.sbc"]')
                .text()
                .replace(/\s /gi, '');

            const fileName = $('.kxbc[jsaction="llc.pbc"]')
                .text()
                .replace(/\s/gi, ' ')
                .replace(/  /gi, '')
                .replace(/ /gi, '-');

            const newFilePath = path.join(
                __dirname,
                'results',
                `${fileName}.json`
            );

            const finishJson = parseResults(arrayName);

            try {
                result = JSON.stringify(finishJson, null, '\t');
                const newJson = fs.writeFileSync(newFilePath, result);
                console.log(`File ${fileName}.json created successful!`);
            } catch (err) {
                console.error(err);
            }

            resolve(finishJson);
        });
    });
}

function imgLinkExtract() {
    const scripts = [];
    $('script').each((i, el) => {
        scripts[i] = $(el).html();
    });
    const imgScriptsArr = [];
    const imgLinks = [];
    for (let i = 0; i < scripts.length; i++) {
        if (scripts[i].indexOf('kximg') + 1) {
            imgScriptsArr.push(scripts[i].replace(/\s/gi, ''));
        }
    }
    if (imgScriptsArr.length > 1) {
        imgScriptsArr.forEach((el, i) => {
            const linkStart = el.indexOf("vars='") + 6;
            const linkEnd = el.indexOf("';varii");
            const link = el.slice(linkStart, linkEnd).replace(/\\x3d/gi, '');
            imgLinks[i] = link;
        });
    } else {
        let generalLink = imgScriptsArr[0];
        while (generalLink.includes("';varii=['kximg")) {
            const linkStart = generalLink.indexOf("vars='") + 6;
            const linkEnd = generalLink.indexOf("';varii=['kximg");
            const link = generalLink
                .slice(linkStart, linkEnd)
                .replace(/\\x3d/gi, '');
            imgLinks.push(link);
            generalLink = generalLink.slice(linkEnd + 15);
        }
    }
    return imgLinks;
}

function parseResults(arrKey) {
    let finishJson = { [arrKey]: [] };
    const imgLinks = imgLinkExtract();
    if ($('.klitem-tr[aria-label]').length) {
        $('.klitem-tr').each((i, el) => {
            const name = $(el).prop('aria-label');
            const link = `https://www.google.com${$(el).prop('href')}`;
            const image = imgLinks[i] || null;
            const extensions = $(el).find('.klmeta').text();
            if (extensions) {
                extValue = extensions.replace(/\s/gi, '');
                finishJson[arrKey][i] = {
                    name: name,
                    link: link,
                    image: image,
                    extensions: [extValue],
                };
            } else {
                finishJson[arrKey][i] = {
                    name: name,
                    link: link,
                    image: image,
                };
            }
        });
    } else if ($('.klitem[aria-label]').length) {
        $('.klitem').each((i, el) => {
            const name = $(el).prop('aria-label');
            const link = `https://www.google.com${$(el).prop('href')}`;
            const image = imgLinks[i] || null;
            const extensions = $(el).find('.klmeta').text();
            if (extensions) {
                extValue = extensions.replace(/\s/gi, '');
                finishJson[arrKey][i] = {
                    name: name,
                    link: link,
                    image: image,
                    extensions: [extValue],
                };
            } else {
                finishJson[arrKey][i] = {
                    name: name,
                    link: link,
                    image: image,
                };
            }
        });
    } else console.error("Can't find Google Carousel!");
    return finishJson;
}

module.exports = { parseHtml };
