from selenium.webdriver import Firefox
from selenium.webdriver.firefox.options import Options
from bs4 import BeautifulSoup
import json
import re
import sys

class CarouselScraper():
    def __init__(self):
        return

    def createHeadlessBrowser(self):
        options = Options()
        options.add_argument("--headless")
        driver = Firefox(options=options)
        return driver

    def searchCarousel(self, htmlSoup, jsonArrData):
        carousel = htmlSoup.findAll("g-scrolling-carousel")
        # inner list of divs containing images
        aTags = carousel[0].find_all("a")
        
        # loop through list of divs in order to pull data
        for i in range(0, len(aTags)):
            title = aTags[i].attrs['aria-label']
            link  = aTags[i].attrs['href']
            aTagTitle = aTags[i].attrs['title']
            # perform regex to see if date is available
            itemDate = re.findall("\(\d{4}\)", aTagTitle)

            # check if img tag contains encoded src
            img = "null"
            if('src' in aTags[i].img.attrs):
                img = aTags[i].img.attrs['src']
                
            item = {}
            item['name'] = title
            if(len(itemDate) > 0):
                try:
                    item['extensions'] = [itemDate[0][1:-1]]
                except Exception as e:
                    print("value of dateYr is")
                    print(itemDate[0])
            item['link'] = link
            item['image'] = img
            jsonArrData['artworks'].append(item)
        
        return jsonArrData

    def writeJsonArray(self, jsonArrData, outFileName):
        outfile = open(outFileName, 'w')
        json.dump(jsonArrData, outfile, indent=4)
        outfile.close()

    def run(self, inFileName, outFileName):
        jsonArrData = {"artworks": []}
        
        # create firefox driver
        driver = self.createHeadlessBrowser()
        driver.get(inFileName)
        soup = BeautifulSoup(driver.page_source, "html.parser")

        jsonArrData = self.searchCarousel(soup, jsonArrData)

        self.writeJsonArray(jsonArrData, outFileName)

if __name__ == "__main__":
    scraper = CarouselScraper()       
    scraper.run(sys.argv[1], sys.argv[2])
