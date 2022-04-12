import json
from bs4 import BeautifulSoup



VANGOGH = r"./van-gogh-paintings.html"
BARCELONA = r'./barcelonaplayers.html'
JAPAN=r'./japanpainter.html'


scraped_list = []
scraped_dict = dict.fromkeys(['name','date','link','image'])


soup = BeautifulSoup(open(JAPAN, encoding='utf-8').read(),features="html.parser")
data =soup.select('[aria-setsize]')


for result in data:
    # div= result.findChildren("div")
    # print(div[0].select('[aria-hidden]'))
    name = result['aria-label']
    date_raw =result.select('a div')
    for x in date_raw:
        date= x.text
    link = result['href']
    image_raw = result.select('a g-img img ')
    for iterable in image_raw:
        if iterable.has_attr('src'):
            image=iterable['src']
        else:
            image=iterable['data-src']
    scraped_list.append({'name':name,'date':date,'link':link,'image':image})


scraped_json = json.dumps(scraped_list,indent=5)

with open ('japanpainters.json','w',encoding='utf-8') as scraped:
    scraped.write(scraped_json)











