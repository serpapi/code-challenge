import os
import json
import unittest
from bs4 import BeautifulSoup
from google_carousel_scraper import GoogleCarouselScraper

GOOGLE_URL_PREPEND = "https://www.google.com"


class TestGoogleCarouselScraper(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_extract(self):
        g = GoogleCarouselScraper()
        # g.extract("./../files/van-gogh-paintings.html", "./output/artworks_array.json")
        g.extract("van-gogh-paintings.html", "./output/artworks_array.json")

        self.assertIsNotNone(g.html_file)
        self.assertIsNotNone(g.json_file_name)
        self.assertIsNotNone(g.soup)
    
    def test_parse_carousel_item(self):
        g = GoogleCarouselScraper()
        num_of_results = len(g.results)

        # parse HTML using BeautifulSoup (used first item in carousel but shorted href)
        carousel_item = BeautifulSoup("""
        <div class="MiPcId klitem-tr mlo-c r-ixoX45d0SyNs" jsl="$t t-K64WL0oiT1I;$x 0;" style="height:197px;width:120px;margin-right:8px"><a aria-label="The Starry Night" aria-posinset="1" aria-setsize="51" class="klitem" data-hveid="47" data-sp="0,17,26" data-ved="0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw" href="/search?Msyi0sTc" role="button" style="height:193px;width:120px" title="The Starry Night (1889)"><div class="klzc" style="margin-bottom:0"><div class="klic" style="height:120px;width:120px"><g-img class="BA0A6c" style="height:120px;width:120px"><img alt="" class="rISBZc M4dUYb" data-deferred="1" data-key="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0" height="120" id="kximg0" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" width="120"/></g-img></div></div><div><div class="kltat"><span>The Starry </span><wbr/><span>Night</span><wbr/></div><div class="ellip klmeta">1889</div></div></a></div>
        """, 'html.parser')

        # pass in carousel_item to parse_carousel_item()
        g.parse_carousel_item(carousel_item)

        # results array should have one more item added
        new_num_of_results = len(g.results)
        self.assertEqual(new_num_of_results, num_of_results + 1)

        # test values for last item in results array
        new_result = g.results[-1]
        self.assertEqual(new_result["name"], "The Starry Night")
        self.assertEqual(new_result["extensions"], ["1889"])
        self.assertEqual(new_result["link"], GOOGLE_URL_PREPEND + "/search?Msyi0sTc")
        self.assertEqual(new_result["image"], "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")

        # new carousel item (this one doesn't contain a year)
        carousel_item_2 = BeautifulSoup("""
        <div class="MiPcId klitem-tr mlo-c r-isjKlGqu4DQg" jsl="$t t-K64WL0oiT1I;$x 0;" style="height:197px;width:120px;margin-right:8px"><a aria-label="Sunflowers" aria-posinset="3" aria-setsize="51" class="klitem" data-hveid="53" data-sp="2,44,44" data-ved="0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYINQ" href="/search?0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYINQ" role="button" style="height:193px;width:120px" title="Sunflowers"><div class="klzc" style="margin-bottom:0"><div class="klic" style="height:120px;width:120px"><g-img class="BA0A6c" style="height:120px;width:120px"><img alt="" class="rISBZc M4dUYb" data-deferred="1" data-key="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJa5Y-t9vzkSCGg06vPfh_mBSZj4JyJ3eE98cFeCkFxJCXcTI2qr1jbv3Bi0Pv5jxouU0" height="120" id="kximg2" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" width="120"/></g-img></div></div><div><div class="kltat"><span>Sunflowers</span><wbr/></div></div></a></div>
        """, "html.parser")
        
        # pass in carousel_item_2 to parse_carousel_item()
        g.parse_carousel_item(carousel_item_2)

        # test values for last item (carousel_item_2) in results array
        new_result = g.results[-1]
        self.assertEqual(new_result["name"], "Sunflowers")
        self.assertRaises(KeyError, lambda: new_result["extensions"])
        self.assertEqual(new_result["link"], GOOGLE_URL_PREPEND + "/search?0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYINQ")
        self.assertEqual(new_result["image"], "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")
    
    def test_write_to_json_file(self):
        json_file_name = "./output/test_output.json"
        g = GoogleCarouselScraper()
        g.json_file_name = json_file_name

        # if test file already exists, delete it so we can test writing file functionality
        if os.path.isfile(json_file_name):
            os.remove(json_file_name)

        # dummy data for JSON file
        json_items = [ 
            { "name": "The Starry Night", "extensions": ["1889"] }, 
            { "name": "Irises", "extensions": ["1889"] },
            { "name": "Sunflowers" }
        ]

        # set results to dummy data and then tell class to write results to JSON file
        g.results = json_items
        g.write_to_json_file()
        
        # Assert that new file exists
        self.assertEqual(True, os.path.isfile(json_file_name))


if __name__ == '__main__':
    unittest.main()