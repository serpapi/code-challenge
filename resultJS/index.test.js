const { request, parse } = require('./index');
global.fetch = require('node-fetch');

describe('Request result:', () => {
    const url = 'https://jsonplaceholder.typicode.com/todos/1';
    const response = ' ';
    test('is not undefined', () => {
        return parse(url).then((data) => {
            expect(data).toBeDefined();

            for (let artwork in data.artworks) {
                expect(artwork.name).toBeDefined();
                expect(artwork.image).toBeDefined();
                expect(artwork.name).toBeDefined();
                expect(artwork.extensions).toBeInstanceOf(Array);
            }
        });
    });
});
