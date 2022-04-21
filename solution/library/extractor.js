const fs = require('fs');
const { Result, Finder, getImageSource } = require('./models')

/*
    extracting features with a virtual document, 
    created with someone else's library (https://www.npmjs.com/package/node-html-parser)
*/
function easyMethod(text, { base, name, extensions, link, image}){
    const parse = require('node-html-parser').parse;
    const document = parse(text);    
    const relevantElements = document.querySelectorAll(base);
    const imageSourceBlocks = Array.from(document.querySelectorAll('script'))
        .find(script => script.innerText.indexOf('_setImagesSrc') > -1)
        .innerText
        .split('_setImagesSrc(ii,s)');

    return relevantElements.map(el => {
        try {
            return new Result(
                el.querySelector(name)?.innerText,
                Array.from(el.querySelectorAll(extensions)).map(node => node.innerText),
                el.querySelector(link)?.attributes.href,
                getImageSource(el.querySelector(image), imageSourceBlocks)
            ).toJson()
        }
        catch(err){
            console.warn(`Error finding result:\n${err}`);
            return null;
        }
    }).filter(result => !!result);
}

/*
    extracting features directly from the string
    created vanilla JS; no third party libraries
*/
function lessEasyMethod(text, { base, name, extensions, link, image, tag }) {
    let set = [],
        startTag = `<${tag}`,
        endTag = `</${tag}>`
        startIndex = text.indexOf(startTag) + startTag.length,
        endIndex = text.indexOf(endTag),
        targetArea = text.substring(startIndex, endIndex),
        targets =  targetArea.split(base.split('.').pop()),
        imageSourceBlocks = text.substring(text.indexOf('function _setImagesSrc'),text.lastIndexOf('_setImagesSrc(ii,s)'))            
            .split('_setImagesSrc(ii,s)');

    targets.shift();
    let i = 0;
    for(let target of targets){
        i+=1;
        let finder = new Finder(target);
        try{
            set.push(
                new Result(
                    finder.name(),
                    finder.extensions(),
                    finder.link(), 
                    finder.image(imageSourceBlocks)
                ).toJson()
            );
        } catch(err){
            console.warn(`Error finding result:\n${err}`);
        }
    }    
    return set;
}



const extract = function({source, selectors }){
    const text = fs.readFileSync(source,'utf-8');
    return {
        resultSetEasyMethod: easyMethod(text, selectors),
        resultSetLessEasyMethod: lessEasyMethod(text, selectors)
    }
}

exports.extract = extract;