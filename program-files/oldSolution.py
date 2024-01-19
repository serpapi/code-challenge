import os
import re
import json
from bs4 import BeautifulSoup

htmlFile = './files/van-gogh-paintings.html'

# Create a dict to host the data
art = {'artworks':[]}

#ignore errors to read the other example html files - utf-8 will break characters in the van-gogh scrape 
with open (htmlFile,"r", errors="ignore") as f:
    rawHtml = BeautifulSoup(f,'html.parser')

# target the google carousel
for tag in rawHtml.find('g-scrolling-carousel'):

    #grab each painting from their anchor tag within the carousel
    paintings = tag.findAll('a')

    #iterate through the paintings
    for painting in paintings:
        
        #The name will always be set by the aria label tag - Could also find this as the [-2] item of the <a> tag
        name = painting['aria-label']

        #The link will always be the href set for the anchor
        link = 'https://www.google.com' + painting['href']
        
        # When included, this will be the final item in the anchor tag
        extension = painting.findAll('div')[-1].text

        # Add data to dict so it can be marshaled to json and saved
        art['artworks'].append({'Name':name,'Extension':[extension],'Url':link})

    with open('Gogh.json', 'w', encoding='utf-8') as f:
        json.dump(art, f, ensure_ascii=False, indent=4)

