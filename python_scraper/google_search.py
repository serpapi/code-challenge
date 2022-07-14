# -*- coding: utf-8 -*-
import requests, lxml
import json
import re
from bs4 import BeautifulSoup


ENCODING = 'utf-8'
headers = {
    'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36'
}

html = requests.get('https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html', headers=headers).text
soup = BeautifulSoup(html, 'lxml')

# Extract name, extensions array (date/year), Google link, and image thumbnail in an array
names = []
extensions = []
links = []
images = []
names_text = soup.find_all('a', class_='klitem')
for name in names_text:
    names.append(name['aria-label'])
    links.append('https://www.google.com' + name['href'])
extensions_text = soup.find_all('div', class_='ellip klmeta')
for year in extensions_text:
    extensions.append(year.text)
print(len(names))
print(len(extensions))
print(len(links))


# dict = {
#     'name': '',
#     'extensions': [],
#     'link': '',
#     'image': ''
# }
# artworks = {}
# artworks.append(dict)

# result = json.dumps(artworks)
