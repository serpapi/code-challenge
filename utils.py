import json


def parse_scraper_result_to_json(results):
    if results:
        with open('result.json', 'w') as fp:
            json.dump(results, fp, ensure_ascii=False)
