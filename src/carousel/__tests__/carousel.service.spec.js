const { 
  getMockInvalidHTML, 
  getMockValidHTMLWithoutCarousel, 
  getMockValidWithCorouselHTML 
} = require("../__mocks/corousel.mocks");
const { getCarousels } = require('../carousel.service');
const fs = require('fs');


describe('Corousel service test suite', () => {
    beforeEach(async () => {
      jest.resetAllMocks();
    });
  
    afterEach(async () => {
      expect.hasAssertions();
    });

    describe('#getCarousels', () => {
      it('should gracefully return empty array if input is null', () => {
        // Given
        const nullInput = null;

        // When
        const serpItems = getCarousels(nullInput);

        // Then
        expect(serpItems).toEqual([]);
      });

      it('should gracefully return empty array if HTML is invalid', () => {
        // Given
        const invalidHtml = getMockInvalidHTML();

        // When
        const serpItems = getCarousels(invalidHtml);

        // Then
        expect(serpItems).toEqual([]);
      });

      it('should gracefully return empty array if HTML is valid but without any carousel element', () => {
        // Given
        const validHtmlWithoutCarousel = getMockValidHTMLWithoutCarousel();

        // When
        const serpItems = getCarousels(validHtmlWithoutCarousel);

        // Then
        expect(serpItems).toEqual([]);
      });

      it('should return list of corousel elements if valid HTML with corousel', () => {
        // Given
        const validHtmlWithCarousel = getMockValidWithCorouselHTML();

        // When
        const serpItems = getCarousels(validHtmlWithCarousel);

        // Then
        const expectedJson = JSON.parse(`{${fs.readFileSync('./files/expected-array.json')}}`);
        expect(serpItems).toEqual(expectedJson.artworks);
      });
    });
});
