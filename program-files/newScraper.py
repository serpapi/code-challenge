import os
import re
import json
from bs4 import BeautifulSoup

htmlPath = './files/'
htmlDoc = 'top-mmorpgs.html'
htmlFile = htmlPath + htmlDoc

#ignore errors to read the other example html files
with open (htmlFile,"r", errors="ignore", encoding='utf-8') as f:
    rawHtml = BeautifulSoup(f,'html.parser')

topLevel = rawHtml.find('div',{'data-ipr':True,'data-vmt':True})

playerNames = []
playerDescription = []
playerSearch = []
playerTeam = []
playerData = {'Players':[]}

def scrapeData():

    names = topLevel.find_all('div',{'data-entityname':True})
    for x in names:
        name = x.text
        playerNames.append(name)
        t = x.fetchNextSiblings()
        for item in t:
            playerTeam.append(item.text)
    descriptions = topLevel.find_all('div',{'data-attrid':"description"})
    for x in descriptions:
        description = x.get_text(separator=':').split(':')
        #print(description[1])
        playerDescription.append(description[1])
    for a in topLevel.findAll('a'):
        children = a.findChildren('g-raised-button', recursive=False)
        for child in children:
            playerSearch.append(a['href'])
    zipData = zip(playerNames,playerTeam,playerDescription,playerSearch) 
    for i in zipData:
        playerData['Players'].append({'Name':i[0],'Additional Data':i[1],'Description':i[2],'Google Search':i[3]})

    with open(htmlDoc+'.json', 'w', encoding='utf-8') as f:
        json.dump(playerData, f, ensure_ascii=False, indent=4)
    
scrapeData()


