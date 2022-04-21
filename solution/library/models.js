/*
    utility functions
*/
String.prototype.decode = function(){
    //return decodeURI(this.toString());
    // note: looks like the test data has some special characters decoded and some encoded; looks like we should handle them one by one as necessary?
    return this.replace(/&amp;/g,'&');
}

Array.prototype.first = function(){
        return this[0];
}

function getImageSource(el,blocks){
    try{         
        return blocks
            .find(block => block.indexOf(`ii=['${el.attributes.id}']`) > -1)
            .match(/data:image\/jpeg;base64,(.*?[^';])'/i)[0]
            .replace(/\\x/g,'x')
            .replace(/'$/,'');
    }catch(err){
        //console.warn(`Unable to get image source for element #${el?.attributes?.id}`);
        return null;
    }    
}


class Finder  {
    constructor(text, classes){
        this.text = text || '';
    }
    name(){
        return this.text.match(/class="kltat".*?<\/div>/is)?.
            first().
            match(/(>.*?)+</g)?.
            map(match => match.replace(/<|>/g,''))
            .join(' ') || '';
    }
    extensions(){
        return this.text.match(/class="ellip klmeta".*?<\/div>/is)?.
            map(x => x.match(/>(\w ?)+</gis)?.first())?.
            map(match => match.replace(/<|>/g,'')) || [];
    }
    link(){
        return this.text.match(/href="\/search\?.*?"/i)?.
            first().
            replace(/href="|"/gi,'') || '';
    }
    image(blocks){
        let id = this.text.match(/id="kximg\d+"/gi)?.first().replace(/id="?|"/g,'');
        if(id){
            return getImageSource({attributes: { id }}, blocks);
        }        
        else {
            return null;
        }
    }
}
class Result {
    constructor(name,extensions,link,image){
        if(!name || !extensions || !link){
            throw `Values missing in result construction: ${name ? '' : 'name,'}${extensions ? '' : 'extensions,'}${link ? '' : 'link'}`
        }
        this.name = name.trim().replace(/ {2,}/g,' ');
        this.extensions = extensions.map(x => x.trim());
        this.link = link.trim().indexOf('https://www.google.com') === 0 ? link.trim().decode() : `https://www.google.com${link.trim().decode()}`;
        this.image = image?.trim() || null
    }
    toString() {
        return JSON.stringify(this);
    }
    toJson( ){
        return Object.assign({}, this);
    }
}

exports.Finder = Finder;
exports.Result = Result;
exports.getImageSource = getImageSource;