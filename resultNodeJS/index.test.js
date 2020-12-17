const fs = require('fs');
const { parseHtml } = require('./index');

describe('Parse Van Gogh result:', () => {
    let data;
    beforeAll(async () => {
        const PARSE_URL = './files/van-gogh-paintings.html';
        data = await parseHtml(PARSE_URL);
    });

    test('is not undefined', () => {
        expect(data).toBeDefined();
    });

    test('has a neccesary keys', () => {
        data.Artworks.forEach((el) => {
            expect(el.name).toBeDefined();
            expect(el.image).toBeDefined();
            expect(el.link).toBeDefined();
        });
    });

    test('has a correct extensions value types', () => {
        data.Artworks.forEach((el) => {
            if (el.extensions) {
                expect(el.extensions).toBeInstanceOf(Array);
            }
        });
    });
});

describe('Parse Van Gogh new result:', () => {
    let data;
    beforeAll(async () => {
        const PARSE_URL = './files/van-gogh-paintings-new.html';
        data = await parseHtml(PARSE_URL);
    });

    test('is not undefined', () => {
        expect(data).toBeDefined();
    });

    test('has a neccesary keys', () => {
        data['Произведения искусства'].forEach((el) => {
            expect(el.name).toBeDefined();
            expect(el.image).toBeDefined();
            expect(el.link).toBeDefined();
        });
    });

    test('has a correct extensions value types', () => {
        data['Произведения искусства'].forEach((el) => {
            if (el.extensions) {
                expect(el.extensions).toBeInstanceOf(Array);
            }
        });
    });
});

describe('Parse Michelangelo result:', () => {
    let data;
    beforeAll(async () => {
        const PARSE_URL = './files/michelangelo-paintings.html';
        data = await parseHtml(PARSE_URL);
    });

    test('is not undefined', () => {
        expect(data).toBeDefined();
    });

    test('has a neccesary keys', () => {
        data['Произведения искусства'].forEach((el) => {
            expect(el.name).toBeDefined();
            expect(el.image).toBeDefined();
            expect(el.link).toBeDefined();
        });
    });

    test('has a correct extensions value types', () => {
        data['Произведения искусства'].forEach((el) => {
            if (el.extensions) {
                expect(el.extensions).toBeInstanceOf(Array);
            }
        });
    });
});

describe('Parse Ivan Aivazovsky result:', () => {
    let data;
    beforeAll(async () => {
        const PARSE_URL = './files/aivazovsky-paintings.html';
        data = await parseHtml(PARSE_URL);
    });

    test('is not undefined', () => {
        expect(data).toBeDefined();
    });

    test('has a neccesary keys', () => {
        data['Произведения искусства'].forEach((el) => {
            expect(el.name).toBeDefined();
            expect(el.image).toBeDefined();
            expect(el.link).toBeDefined();
        });
    });

    test('has a correct extensions value types', () => {
        data['Произведения искусства'].forEach((el) => {
            if (el.extensions) {
                expect(el.extensions).toBeInstanceOf(Array);
            }
        });
    });
});

describe('Parse Jason Statham result:', () => {
    let data;
    beforeAll(async () => {
        const PARSE_URL = './files/jason-statham-movies.html';
        data = await parseHtml(PARSE_URL);
    });

    test('is not undefined', () => {
        expect(data).toBeDefined();
    });

    test('has a neccesary keys', () => {
        data['Фильмы'].forEach((el) => {
            expect(el.name).toBeDefined();
            expect(el.image).toBeDefined();
            expect(el.link).toBeDefined();
        });
    });

    test('has a correct extensions value types', () => {
        data['Фильмы'].forEach((el) => {
            if (el.extensions) {
                expect(el.extensions).toBeInstanceOf(Array);
            }
        });
    });
});
