import json

from challenge import scrape

if __name__ == '__main__':
    json_result = scrape.scrape_art()
    print(json.dumps(json_result, indent=True, ensure_ascii=False))