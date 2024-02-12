import re

from bs4 import BeautifulSoup

def scrape_art():
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
            'name': art['aria-label'],
            'link': 'https://www.google.com' + art['href']
        }

        if year := art.find('div', attrs={'class': 'klmeta'}):
            entry['extensions'] = [ year.text ]

        image_id = art.find('g-img').img['id']
        if image_id in img_lookup:
            # Handle pesky hex escapes ('\' isn't valid b64 anyways..)
            # Still loads using <img src=...>
            entry['image'] = img_lookup[image_id].replace('\\', '')
        else:
            entry['image'] = None

        json_result['artworks'].append(entry)
    
    return json_result