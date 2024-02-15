jest.useRealTimers();
const path = require('path');

const url1 = 'file:' + path.resolve(__dirname, '../files/van-gogh-paintings.html');
const url2 = 'https://rb.gy/os3b0t'; 

//test for .html file page's title
describe('Google', () => {
    beforeAll(async () => {
      await page.goto(url1);
    });
  
    it('should be titled "Google"', async () => {
      await expect(page.title()).resolves.toMatch('Google');
    });
  });

//test for live URL's title
describe('Google', () => {
    beforeAll(async () => {
      await page.goto(url2);
    });
  
    it('should be titled "Google"', async () => {
      await expect(page.title()).resolves.toMatch('Google');
    });
  });