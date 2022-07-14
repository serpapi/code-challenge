const GoogleCardScraper = require("./scraper/scraper");
const readFileSync = require('fs').readFileSync;

(async() => {
    'use strict';

    const target = 'https://www.google.com';

    describe('small file', () => {
        let results = null;
        beforeAll(() => {
            const scraper = new GoogleCardScraper(`
            <html>
                <g-scrolling-carousel>
                        <a href="/foo" title='foo bar'>
                            <g-img>
                                <img src="dummyval"/>
                            </g-img>
                        </a>
                </g-scrolling-carousel>

                <script>
                    (function() {
                        document.querySelector('g-img > img').src = "base64Val";
                    })();
                </script>
            </html>`, target);

            results = scraper.getCards();    
        });

        test('if result is not null', () => {
            expect(results).toBeDefined();
        });

        test('if artwork has name', () => {
            expect(results[0].name).toEqual('foo bar');
        });

        test('if artwork has correct image source type', () => {
            expect(results[0].image).toEqual('base64Val')
        });
    });

    describe('big file', () => {
        let results = null;
        beforeAll(() => {
            const scraper = new GoogleCardScraper(readFileSync('input/google.html', 'utf-8'), target);
            results = scraper.getCards();    
        });
    
        test('if result is not null', () => {
            expect(results).toBeDefined();
        });
    
        test('if artworks have name', () => {
            expect(results[0].name.length).toBeGreaterThan(0);
        });
    
        test('if images were properly rendered', () => {
            results.forEach(e => {
                if (e.image) {
                    expect(e.image).toMatch(/data:image\/jpeg/);
                }
            });
        });
    
        test('if link starts with target', () => {
            results.forEach(e => {
                expect(e.link).toMatch(new RegExp(`^${target}`));
            });
        });
    });

    describe('unexpected functionality', () => {
        test('if malformed file empty results', () => {
            expect(
                new GoogleCardScraper(``, target).getCards()
            ).toStrictEqual([])
        });

        test('if parsing error empty results', () => {
            expect(
                new GoogleCardScraper(``, target).getCards()
            ).toStrictEqual([])
        });

        test('if cards with no name are not included', () => {
            expect(
                new GoogleCardScraper(`
                    <html>
                    <g-scrolling-carousel>
                            <a>
                                <g-img>
                                    <img src="dummyval"/>
                                </g-img>
                            </a>

                            <a href="/foo" title='foo bar'>
                            <g-img>
                                <img src="dummyval"/>
                            </g-img>
                        </a>
                    </g-scrolling-carousel>
                    </html>`, target).getCards()
            ).toStrictEqual([
                {
                    extensions: [],
                    image: "dummyval",
                    link: "https://www.google.com/foo",
                    name: "foo bar",
                },
            ])
        });
    });
})();
