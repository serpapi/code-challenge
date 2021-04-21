const { getSerpItemFromCarouselItem, getBase64ImageFromId } = require("../carousel.presenter");
const { getMockValidWithCorouselHTML, getMockCarouselDomItem } = require("../__mocks/corousel.mocks");
const fs = require('fs');

describe('Corousel presenter test suite', () => {
  beforeEach(async () => {
    jest.resetAllMocks();
  });
  
  afterEach(async () => {
    expect.hasAssertions();
  });
  
  describe('#getSerpItemFromCarouselItem', () => {
    it('should return null if carouselItem is null even with valid html', () => {
      // Given
      const carouselItem = null;
      const validHtmlWithCarousel = getMockValidWithCorouselHTML();
      
      // When
      const serpItem = getSerpItemFromCarouselItem(carouselItem, validHtmlWithCarousel);
      
      // Then
      expect(serpItem).toEqual(null);
    });
    
    it('should return null if carouselItem is valid even with null html', () => {
      // Given
      const carouselItem = getMockCarouselDomItem();
      const nullHtml = null;
      
      // When
      const serpItem = getSerpItemFromCarouselItem(carouselItem, nullHtml);
      
      // Then
      expect(serpItem).toEqual(null);
    });
    
    it('should map to serp item format if payload is valid', () => {
      // Given
      const carouselItem = getMockCarouselDomItem();
      const validHtml = getMockValidWithCorouselHTML();
      
      // When
      const serpItem = getSerpItemFromCarouselItem(carouselItem, validHtml);
      
      // Then
      const expectedJson = JSON.parse(`{${fs.readFileSync('./files/expected-array.json')}}`);
      expect(serpItem).toEqual(expectedJson.artworks[0]);
    });
  });

  describe('#getBase64ImageFromId', () => {
    it('should return null if id is null even with valid html', () => {
      // Given
      const nullId = null;
      const validHtmlWithCarousel = getMockValidWithCorouselHTML();
      
      // When
      const image = getBase64ImageFromId(nullId, validHtmlWithCarousel);
      
      // Then
      expect(image).toEqual(null);
    });
    
    it('should return null if id is valid even with null html', () => {
      // Given
      const validId = 'kximg0';
      const nullHtml = null;
      
      // When
      const image = getBase64ImageFromId(validId, nullHtml);
      
      // Then
      expect(image).toEqual(null);
    });

    it('should return null if payload is valid but image is not found', () => {
      // Given
       const validId = 'kximg10';
       const validHtml = getMockValidWithCorouselHTML();
       
       // When
       const image = getBase64ImageFromId(validId, validHtml);
      
      
      // Then
      expect(image).toEqual(null);
    });
    
    it('should return corresponding base64 image if found', () => {
      // Given
       const validId = 'kximg0';
       const nullHtml = getMockValidWithCorouselHTML();
       
       // When
       const image = getBase64ImageFromId(validId, nullHtml);
      
      
      // Then
      const expectedJson = JSON.parse(`{${fs.readFileSync('./files/expected-array.json')}}`);
      expect(image).toEqual(expectedJson.artworks[0].image);
    });
  });
});
