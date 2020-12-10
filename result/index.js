let finishJson = {};

function request(url) {
    return new Promise(() => {
        const request = new XMLHttpRequest();
        request.open('GET', url);
        request.send();
        request.onload = function () {
            const result = request.response;
            const container = document.getElementsByTagName('body');
            const answer = document.createElement('div');
            answer.innerHTML = result;
            container[0].append(answer);
            const helpArray = document.querySelectorAll('.kxbc');
            let arrName = '';
            helpArray.forEach((el) => {
                let jsaction = el.getAttribute('jsaction');
                if (jsaction === 'llc.sbc') {
                    arrName = el.textContent;
                }
            });
            parseResults(arrName);
            saveJSON(finishJson);
        };
    });
}

function parseResults(arrKey) {
    finishJson = { [arrKey]: [] };
    const links = document.querySelectorAll('.klitem');
    links.forEach((el, i) => {
        const name = el.getAttribute('aria-label');
        const link = `https://www.google.com${el.getAttribute('href')}`;
        const image = el.querySelector('img').getAttribute('src');
        const extensions = el.querySelector('.klmeta');
        if (extensions) {
            let extValue = extensions.textContent;
            extValue = extValue.replace(/\s/gi, '');
            finishJson[arrKey][i] = {
                name: name,
                link: link,
                image: image,
                extensions: extValue,
            };
        } else {
            finishJson[arrKey][i] = { name: name, link: link, image: image };
        }
    });
    console.log(finishJson);
    finishJson = JSON.stringify(finishJson[arrKey], null, '\t');
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

// request('../files/van-gogh-paintings.html');
request(
    'https://www.google.com/search?sxsrf=ALeKk01RlX8FDelSD7-ejmdkG98FgWO9UQ%3A1607599444000&ei=UwXSX9bHPMSMrwTDt7yADg&q=michelangelo+paintings&oq=mi+paintings&gs_lcp=CgZwc3ktYWIQARgAMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB5QwGZYxWhgwHloAHAAeACAAY0BiAGMApIBAzAuMpgBAKABAaoBB2d3cy13aXrAAQE&sclient=psy-ab'
);
