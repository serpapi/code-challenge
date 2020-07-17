const { parsePaintings } = require('./index');

const cheerio = require('cheerio');
const fs = require('fs');
const path = require('path');

jest.mock('fs');
jest.mock('path');
jest.mock('cheerio');

const samplePaintings = [
  {
    name: 'The Starry Night',
    extensions: ['1889'],
    link: 'https://www.google.com/search?q=a',
    image: 'image a',
  },
  {
    name: 'Irises',
    extensions: ['1889'],
    link: 'https://www.google.com/search?q=b',
    image: 'image b',
  },
];
function cheerioLoadSimpleMock() {
  return {
    first: () => ({
      find: () => ({
        map: () => ({
          get: () => samplePaintings,
        }),
      }),
    }),
  };
}
describe('index.js', () => {
  describe('parsePaintings', () => {
    beforeEach(() => {
      cheerio.load.mockImplementation(() => cheerioLoadSimpleMock);
    });

    it('should have parsePaintings function', () => {
      expect(parsePaintings).toBeDefined();
    });

    it('should call cheerio.load once', () => {
      parsePaintings();
      expect(cheerio.load).toHaveBeenCalledTimes(1);
    });

    it('should return paintings successfully', () => {
      const paintings = parsePaintings();
      expect(paintings).not.toBeNull();
      expect(paintings).toEqual(samplePaintings);
    });

    it('should return paintings array of length 2', () => {
      const paintings = parsePaintings();
      expect(paintings.length).toEqual(2);
    });
  });
});
