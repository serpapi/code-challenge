# -*- coding: utf-8 -*-
from bs4 import BeautifulSoup as Soup
import requests
import re
import json

search_url = 'https://www.google.com/search?q=Van+Gogh+paintings'

#testing other urls
#search_url = 'https://www.google.com/search?q=dog+breeds'
#search_url = 'https://www.google.com/search?q=tree+types'

#set headers
header={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', "content-type": "image/png"}

googlebaseurl = "https://www.google.com"

search_response = requests.get(search_url, headers=header)

search_soup = Soup(search_response.content, 'html.parser')

#get correct divs
carousel_regex = re.compile('kc*')

match = search_soup.find("div", {"data-attrid": carousel_regex})


pictures = match.find("div")
jsnameregex = re.compile('\w*')
maindiv = pictures.find("div", {"jsname": jsnameregex})   

jsdataregex = re.compile('\w*')
individualdiv = maindiv.find_all("div", {"jsdata": jsdataregex})


#testing to put into function
#testdiv = individualdiv[0]
#print(testdiv)
#name = testdiv.find_all("div")[1].text
#print(name)
#link = testdiv.find('a', href=True)['href']
#print(link)
#img_src = testdiv.find('img').get("src")
#print(img_src)

artworks = []
def getInfo(div):
    
    div.find_all("div")
    name = div.find_all("div")[1].text
    
    
    
    try:
        date = div.find_all("div")[2].text
    except:
        pass
    
    
    link = googlebaseurl + div.find('a').get('href')
    
    image = div.find('img').get("src")
    
    
    result = {}
    result['name'] = name
    result['extensions'] = [date]
    result['link'] = link
    result['image'] = image
    
    artworks.append(result)
    
    

for div in individualdiv:
    getInfo(div)
    
    
#print(artworks)

data = {}
data['artworks'] = artworks
json_data = json.dumps(data)
print(json_data)
