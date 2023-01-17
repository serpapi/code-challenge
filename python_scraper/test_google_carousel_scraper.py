import unittest
from google_carousel_scraper import GoogleCarouselScraper

class TestGoogleCarouselScraper(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_extract(self):
        g = GoogleCarouselScraper()
        g.extract("./../files/van-gogh-paintings.html")

        self.assertIsNotNone(g.html_file)
      


if __name__ == '__main__':
    unittest.main()