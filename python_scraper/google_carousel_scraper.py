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
        
        # print(self.soup)