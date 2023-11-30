from scraper import scrape_paintings_data
from utils import parse_scraper_result_to_json

if __name__ == '__main__':
    scraper_result = scrape_paintings_data('Van Gogh')
    parse_scraper_result_to_json(scraper_result)
