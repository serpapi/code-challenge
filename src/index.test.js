jest.useRealTimers();
const path = require('path');

const url1 = 'file:' + path.resolve(__dirname, '../files/van-gogh-paintings.html');
const url2 = 'https://rb.gy/os3b0t'; 


describe('Google', () => {
    beforeAll(async () => {
      await page.goto(url1);
    });
  
    it('should be titled "Google"', async () => {
      await expect(page.title()).resolves.toMatch('Google');
    });
  });

  describe('Google', () => {
    beforeAll(async () => {
      await page.goto(url2);
    });
  
    it('should be titled "Google"', async () => {
      await expect(page.title()).resolves.toMatch('Google');
    });
  });