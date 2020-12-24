const fs = require('fs');
const { parseHtml } = require('./index');

jest.setTimeout(30000);

describe('Carousel parse result:', () => {
    let data = [];
    let keys = [];
    beforeAll(async () => {
        const PARSE_URL = [
            './files/van-gogh-paintings.html',
            './files/van-gogh-paintings-new.html',
            './files/michelangelo-paintings.html',
            './files/aivazovsky-paintings.html',
            './files/jason-statham-movies.html',
        ];
        await Promise.all(
            PARSE_URL.map(async (el) => {
                data.push(await parseHtml(el));
            })
        );
        data.map((el) => {
            keys.push(...Object.keys(el));
        });
    });

    test('is not undefined', () => {
        keys.map((el, i) => {
            expect(data[i][el]).toBeDefined();
        });
    });

    test('has a neccesary keys', () => {
        keys.map((el, i) => {
            data[i][el].forEach((el) => {
                expect(el.name).toBeDefined();
                expect(el.image).toBeDefined();
                expect(el.link).toBeDefined();
            });
        });
    });

    test('has a correct extensions value types', () => {
        keys.map((el, i) => {
            data[i][el].forEach((el) => {
                if (el.extensions) {
                    expect(el.extensions).toBeInstanceOf(Array);
                }
            });
        });
    });
});
