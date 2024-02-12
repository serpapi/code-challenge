import json

from challenge.scrape import scrape_art

def test_expected_array():
    with open('files/expected-array.json', 'r') as f:
        expected_art_json = json.loads('{' + f.read() + '}')

    assert scrape_art() == expected_art_json