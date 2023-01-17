import json
from bs4 import BeautifulSoup

class GoogleCarouselScraper:
    def __init__(self):
        self.results = []
        self.html_file = None
        self.json_file_name = None
        self.soup = None
        self.google_url_prepend = "https://www.google.com"
    
    def extract(self, html_file, json_file_name):
        self.html_file = html_file
        self.json_file_name = json_file_name


        # read file and parse HTML w/ BeautifulSoup
        with open(self.html_file, 'r') as f:
            contents = f.read()
            self.soup = BeautifulSoup(contents, 'html.parser')
        
        # identify scrolling carousel and fetch all items
        carousel = self.soup.find('div', {'id': 'appbar'}).find('g-scrolling-carousel')
        carousel_items = carousel.findAll('div', {'class': 'MiPcId'})

        # iterate thru carousel_items and pass into parse_carousel_item() method
        for carousel_item in carousel_items:
            self.parse_carousel_item(carousel_item)
        
        # write results to JSON
        self.write_to_json_file()
    
    def parse_carousel_item(self, carousel_item):
        obj = {}
    
        link_container = carousel_item.find('a')

        title = link_container.get('aria-label')
        obj["name"] = title.strip()

        # parse year
        year_div = link_container.find('div', {'class': 'ellip'})
        if year_div != None:
            year_produced = year_div.text.strip()
            obj["extensions"] = [year_produced]

        
        href = link_container.get("href")
        obj["link"] = self.google_url_prepend + href.strip()

        image_container = link_container.find("img")
        image_src = image_container.get("src")
        if image_src != None:
            obj["image"] = image_src.strip()
        else:
            obj["image"] = None

        self.results.append(obj)
    
    def write_to_json_file(self):
        # create dict
        artworks_array = {"artworks": self.results}

        # Serialize JSON
        json_object = json.dumps(artworks_array, indent=2)

        # Write to JSON file
        with open(self.json_file_name, "w") as outfile:
            outfile.write(json_object)