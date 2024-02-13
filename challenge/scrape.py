import re

from bs4 import BeautifulSoup

def scrape_art():
    with open('./files/van-gogh-paintings.html', 'r') as f:
        parser = BeautifulSoup(f, 'html.parser')

    img_lookup = {}
    for script in parser.find_all('script'):
        img_matches = re.findall(r"'(data:image/jpeg;base64.*?)';.*?\['(.*?)'\];", script.text, re.DOTALL)
        for match in img_matches:
            img_lookup[match[1]] = match[0]

    results = parser.find_all('a', attrs={'class': 'klitem'})
    # 'klitem-tr' seems to work for newer versions of the page
    results = results if len(results) > 0 else parser.find_all('a', attrs={'class': 'klitem-tr'})
    json_result = { 'artworks': [] }
    for art in results:
        entry = {
            'name': art['aria-label'],
            'link': 'https://www.google.com' + art['href']
        }

        if year := art.find('div', attrs={'class': 'klmeta'}):
            entry['extensions'] = [ year.text ]

        entry['image'] = None
        if gimg := art.find('g-img'):
            img = gimg.find('img')
            if img and img['id'] in img_lookup:
                # Handle pesky hex escapes ('\' isn't valid b64 anyways..)
                # Still loads using <img src=...>
                entry['image'] = img_lookup[img['id']].replace('\\', '')

        json_result['artworks'].append(entry)
    
    return json_result