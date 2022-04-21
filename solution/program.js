const { extract } = require('./library/extractor'),
    { compare } = require('./library/compare'),
    fs = require('fs'),
    fileToTestPath = `${__dirname.replace('\\solution','')}/files/van-gogh-paintings.html`,
    expectedResultsPath = `${__dirname.replace('\\solution','')}/files/expected-array.json`,
    outputPath = `${__dirname.replace('\\solution','')}/files/results.json`;

console.log(`Performing the extraction of information from ${fileToTestPath}`);

const { 
    resultSetEasyMethod, 
    resultSetLessEasyMethod 
} = extract({ 
        source: fileToTestPath, 
        selectors: { 
            base: '.MiPcId.klitem-tr', 
            name: '.kltat', 
            extensions: '.ellip.klmeta', 
            link: 'a', 
            image: 'img',
            tag: 'g-scrolling-carousel'
        }
    });

console.log('extraction done\nstarting comparison');

const expectedResultSet = JSON.parse(`{${fs.readFileSync(expectedResultsPath)}}`);

const comparison = compare(expectedResultSet, resultSetEasyMethod, resultSetLessEasyMethod);

console.log(comparison.areEqual ? `Success.\nThe results match the expected value` : `Failure.\nThe results do not match the expected value.\n${comparison.message}`);

if(comparison.areEqual){
    fs.writeFileSync(outputPath,JSON.stringify(resultSetEasyMethod,null,4))
}

console.log(`Results should be viewable at ${outputPath}`);