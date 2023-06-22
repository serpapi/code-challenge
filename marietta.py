from bs4 import BeautifulSoup 
import re
import requests 

site = requests.get("https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html")


soup = BeautifulSoup(site.content, 'html.parser')
images = soup.select('a[aria-posinset]')
all_artworks =  []

for i in images:
    title = i.text.strip()
    year = re.findall(r'\d+', title)
    year = ''.join(year)
    link = 'https://www.google.com' + i['href']
    artwork = {}
    artwork['title'] = title
    artwork['year'] = year
    artwork['link'] = link
    all_artworks.append(artwork)

print(all_artworks)
