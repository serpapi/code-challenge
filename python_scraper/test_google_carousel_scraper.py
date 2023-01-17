import unittest
from bs4 import BeautifulSoup
from google_carousel_scraper import GoogleCarouselScraper

class TestGoogleCarouselScraper(unittest.TestCase):
    def setUp(self):
        pass
    
    def test_extract(self):
        g = GoogleCarouselScraper()
        g.extract("./../files/van-gogh-paintings.html")

        self.assertIsNotNone(g.html_file)
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
        new_num_of_results = len(g.results)

        # results array should have one more item added
        self.assertEqual(new_num_of_results, num_of_results + 1)

        # test values for last item in results array
        new_result = g.results[-1]
        self.assertEqual(new_result["name"], "The Starry Night")
        self.assertEqual(new_result["extensions"], ["1889"])
        self.assertEqual(new_result["link"], "/search?Msyi0sTc")
        self.assertEqual(new_result["image"], "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")
        


if __name__ == '__main__':
    unittest.main()