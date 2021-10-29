const path = require('path');
const { parse } = require('../index');

describe('Google search results page parser', () => {
  let artworks;
  [
    'american-novels.html',
    'ruby-rail-book.html',
    'van-gogh-paintings.html',
  ].map((file, index) => {
    describe(`Parse file: ${file}`, () => {
      beforeAll(async () => {
        artworks = await parse(
          path.join(
            `file://${path.join(__dirname)}`,
            '../../files/',
            file
          )
        );
      });

      test('Should have artworks parsed', () => {
        expect(artworks.length > 0).toBeTruthy();
      });

      describe('Artworks results', () => {
        test('Has a string name', () => {
          expect(
            typeof artworks[0].name === 'string' && artworks[0].name.length > 0
          ).toBeTruthy();
        });
        test('Has a google search link', () => {
          expect(
            artworks[0].link.startsWith('https://www.google.com/search?')
          ).toBeTruthy();
        });
        test('Has a array of extensions or null', () => {
          expect(
            !artworks[0].extensions || Array.isArray(artworks[0].extensions)
          ).toBeTruthy();
        });
        test('Has a image src or null', () => {
          expect(
            artworks[0].image == null ||
              artworks[0].image.startsWith('data:image/')
          ).toBeTruthy();
        });
      });
    });
  });
});
