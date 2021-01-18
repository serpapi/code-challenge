const expectedArray = require('./files/expected-array.json');
const vanGoghPaintings = require('./final-results/van-gogh-paintings.json');
const pietMondrian = require('./final-results/piet-mondrian-artworks.json');
const rubyBooks = require('./final-results/ruby-books.json');
const javascriptBooks = require('./final-results/javascript-books.json');

describe( 'Check Artworks Array For Valid Results', () => {
    test( 'Van Gogh Paintings is equal to Expected Array', () => {
        expect(vanGoghPaintings).toEqual(expectedArray);
    });

    test( 'Piet Mondrian Artworks contains required fields', () => {
        pietMondrian.artworks.forEach(obj => {
            // Name
            expect(typeof obj.name).toBe('string');
            expect(obj.name).toBeTruthy();
            
            // Extensions
            if(obj.extensions) {
                expect(typeof obj.extensions).toBe('object');
            }

            //Link
            expect(typeof obj.link).toBe('string');
            expect(obj.link).toBeTruthy();

            // Img
            if(obj.image !== null) {
                expect(typeof obj.link).toBe('string');
            }  
        });
    });

    test( 'Ruby Books contains required fields', () => {
        rubyBooks.artworks.forEach(obj => {
            // Name
            expect(typeof obj.name).toBe('string');
            expect(obj.name).toBeTruthy();
            
            // Extensions
            if(obj.extensions) {
                expect(typeof obj.extensions).toBe('object');
            }

            //Link
            expect(typeof obj.link).toBe('string');
            expect(obj.link).toBeTruthy();

            // Img
            if(obj.image !== null) {
                expect(typeof obj.link).toBe('string');
            }  
        });
    });

    test( 'JavaScript Books contains required fields', () => {
        javascriptBooks.artworks.forEach(obj => {
            // Name
            expect(typeof obj.name).toBe('string');
            expect(obj.name).toBeTruthy();
            
            // Extensions
            if(obj.extensions) {
                expect(typeof obj.extensions).toBe('object');
            }

            //Link
            expect(typeof obj.link).toBe('string');
            expect(obj.link).toBeTruthy();

            // Img
            if(obj.image !== null) {
                expect(typeof obj.link).toBe('string');
            }  
        });
    });
});