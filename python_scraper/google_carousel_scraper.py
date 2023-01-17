from bs4 import BeautifulSoup

class GoogleCarouselScraper:
    def __init__(self):
        self.results = []
        self.html_file = None
        self.soup = None
        self.google_url_prepend = "https://www.google.com"
    
    def extract(self, html_file):
        self.html_file = html_file

        # read file and parse HTML w/ BeautifulSoup
        with open(self.html_file, 'r') as f:
            contents = f.read()
            self.soup = BeautifulSoup(contents, 'html.parser')
        
        # identify scrolling carousel and send each item to parse_carousel_item() method
        carousel = self.soup.find('div', {'id': 'appbar'}).find('g-scrolling-carousel')
        carousel_items = carousel.findAll('div', {'class': 'MiPcId'})

        for carousel_item in carousel_items:
            self.parse_carousel_item(carousel_item)
    
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