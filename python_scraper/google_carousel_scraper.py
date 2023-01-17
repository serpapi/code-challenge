from bs4 import BeautifulSoup

class GoogleCarouselScraper:
    def __init__(self):
        self.results = []
        self.html_file = None
        self.soup = None
    
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

        self.results.append(obj)