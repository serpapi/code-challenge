async function request(url) {
    return fetch(url)
        .then((res) => {
            return res.text();
        })
        .catch((e) => console.log(e));
}

function createDom(page) {
    const container = document.querySelector('body');
    const answer = document.createElement('div');
    answer.innerHTML = page;
    container.append(answer);
}

function getArrayName() {
    const helpArray = document.querySelectorAll('.kxbc');
    let arrName = '';
    helpArray.forEach((el) => {
        let jsaction = el.getAttribute('jsaction');
        if (jsaction === 'llc.sbc') {
            arrName = el.textContent.replace(/\s /gi, '');
        }
    });
    return arrName;
}

function imgLinkExtract() {
    const scripts = document.getElementsByTagName('script');
    const imgScriptsArr = [];
    const imgLinks = [];
    for (let i = 0; i < scripts.length; i++) {
        if (scripts[i].outerHTML.indexOf('kximg') + 1) {
            imgScriptsArr.push(scripts[i].outerHTML.replace(/\s/gi, ''));
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
        console.log(imgLinks);
    }

    return imgLinks;
}

function parseResults(arrKey) {
    let finishJson = { [arrKey]: [] };
    let links = document.querySelectorAll('.klitem');
    if (links[0].getAttribute('aria-label') === null) {
        links = document.querySelectorAll('.klitem-tr');
    }
    const imgLinks = imgLinkExtract();
    links.forEach((el, i) => {
        const name = el.getAttribute('aria-label');
        const link = `https://www.google.com${el.getAttribute('href')}`;
        const image = imgLinks[i] || null;
        const extensions = el.querySelector('.klmeta');
        if (extensions) {
            let extValue = extensions.textContent;
            extValue = extValue.trim();
            finishJson[arrKey][i] = {
                name: name,
                link: link,
                image: image,
                extensions: extValue,
            };
        } else {
            finishJson[arrKey][i] = {
                name: name,
                link: link,
                image: image,
            };
        }
    });
    finishJson = JSON.stringify(finishJson, null, '\t');
    return finishJson;
}

function saveJSON(data) {
    let bl = new Blob([data], {
        type: 'application/json',
    });
    let a = document.createElement('a');
    a.href = URL.createObjectURL(bl);
    a.download = 'data.json';
    document.body.appendChild(a);
    a.innerHTML = 'Save JSON';
    a.style = `position: absolute; 
        top: 50%; 
        left: 50%; 
        width: 300px; 
        height: 100px; 
        margin: -50px -150px 0 0; 
        font-size: 30px; 
        background-color: red; 
        text-align: center; 
        line-height: 100px`;
}

// request('./files/van-gogh-paintings.html');
// request('./files/van-gogh-paintings-new.html');
// request('./files/michelangelo-paintings.html');
// request('./files/aivazovsky-paintings.html');
request('./files/jason-statham-movies.html')
    .then((data) => createDom(data))
    .then(() => parseResults(getArrayName()))
    .then((data) => saveJSON(data));
