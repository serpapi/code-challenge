import sys
import json
import re

from bs4 import BeautifulSoup

if __name__ == '__main__':
    with open('./files/van-gogh-paintings.html', 'r') as f:
        parser = BeautifulSoup(f, 'html.parser')

    scripts = parser.find_all('script')
    image_load_js = ''
    for script in scripts:
        if '_setImagesSrc' in script.text:
            image_load_js = script.text
    
    img_matches = re.findall(r"'(data:image/jpeg;base64.*?)';.*?\['(.*?)'\];", image_load_js, re.DOTALL)
    img_lookup = {}
    for match in img_matches:
        img_lookup[match[1]] = match[0]

    results = parser.find_all('a', attrs={'class': 'klitem'})
    json_result = { 'artworks': [] }
    for art in results:
        entry = {
            'name': art['title'],
            'link': 'https://google.com' + art['href']
        }

        if year := art.find('div', attrs={'class': 'klmeta'}):
            entry['extensions'] = [ year.text ]

        image_id = art.find('g-img').img['id']
        if image_id in img_lookup:
            json_result['image'] = img_lookup[image_id]
        else:
            json_result['image'] = None

        json_result['artworks'].append(entry)

    print(json.dumps(json_result, indent=True))