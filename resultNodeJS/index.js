const fs = require('fs');
const path = require('path');
const cheerio = require('cheerio');

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

            const finishJson = parseResults(arrayName);

            resolve(finishJson);
        });
    });
}

function imgLinkExtract() {
    const scripts = [];
    $('script').each((i, el) => {
        scripts[i] = $(el).html();
    });
    const imgLinksArr = [];
    const linkExpression = /vars='(.*?)';varii=\['kximg/g;
    const imgLinksString = scripts.join('').replace(/\s/gi, '');
    const links = imgLinksString.matchAll(linkExpression);
    for (link of links) {
        imgLinksArr.push(link[1].replace(/\\x3d/gi, ''));
    }
    return imgLinksArr;
}

function parseResults(arrKey) {
    let finishJson = { [arrKey]: [] };
    const imgLinks = imgLinkExtract();
    $('.klitem-tr[aria-label], .klitem[aria-label]').each((i, el) => {
        const name = $(el).prop('aria-label');
        const link = `https://www.google.com${$(el).prop('href')}`;
        const image = imgLinks[i] || null;
        const extensions = $(el).find('.klmeta').text().replace(/\s/gi, '');
        finishJson[arrKey][i] = {
            name: name,
            link: link,
            image: image,
        };
        if (extensions) {
            finishJson[arrKey][i].extensions = [extensions];
        }
    });
    return finishJson;
}

function saveFile(obj) {
    const fileName = $('.kxbc[jsaction="llc.pbc"]')
        .text()
        .replace(/\s/gi, ' ')
        .replace(/  /gi, '')
        .replace(/ /gi, '-');

    const newFilePath = path.join(__dirname, 'results', `${fileName}.json`);

    try {
        result = JSON.stringify(obj, null, '\t');
        const newJson = fs.writeFileSync(newFilePath, result);
        console.log(`File ${fileName}.json created successful!`);
    } catch (err) {
        console.error(err);
    }
}

function run(PARSE_URL) {
    parseHtml(PARSE_URL).then((res) => saveFile(res));
}

module.exports = { parseHtml, run };
require('make-runnable');
