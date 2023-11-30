import os
import unittest
from scraper import scrape_paintings_data


class TestScraper(unittest.TestCase):
    # Test If HTML file exists
    def test_html_file_exists(self):
        self.assertTrue(os.path.exists('files/van-gogh-paintings.html'))

    # Test if HTML file is not empty
    def test_html_file_not_empty(self):
        self.assertTrue(os.stat('files/van-gogh-paintings.html').st_size != 0)

    # Test if HTML file contains the expected data
    def test_html_file_contains_expected_data(self):
        with open('files/van-gogh-paintings.html', 'r') as file:
            page = file.read()
            self.assertTrue('klitem' in page)
            self.assertTrue('kltat' in page)
            self.assertTrue('klmeta' in page)
            self.assertTrue('klic' in page)

    # Test Length of results
    def test_length_of_results(self):
        scraper_result = scrape_paintings_data('Van Gogh')
        self.assertEqual(len(scraper_result['artworks']), 51)


if __name__ == '__main__':
    unittest.main()
