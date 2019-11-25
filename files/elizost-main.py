import re
import codecs
import json

f=codecs.open('van-gogh-paintings.html','r')
file=f.read()


titles=re.findall(r'<div class="kltat">(.*?)</div>',str(file))
titlesClean=[]

for x in range(len(titles)):
    line=titles[x]
    lineList=line.split('<span>')
    tempList=[]
    for y in range(len(lineList)):
        line=lineList[y]
        end=line.find("</")
        line=line[:end]
        tempList.append(line)
    del tempList[0]
    tempStr=''.join(tempList)
    titlesClean.append(tempStr)
    


dates=re.findall(r'<div class="kltat">(.*?)</a>',str(file))
datesClean=[]

for x in range(len(dates)):
    line=dates[x]
    dateLine=re.findall(r'<div class="ellip klmeta">(.*?)</div></div',str(line))
    if(len(dateLine)==1):
        datesClean.append(dateLine)
    else:
        datesClean.append('')



links=re.findall(r'aria-setsize="51"(.*?)>',str(file))
linksClean=[]

for x in range(len(links)):
    line=links[x]
    start=line.find('" h')
    line=line[start+8:]
    end=line.find('" style')
    line=line[:end]
    line='https://www.google.com'+line
    linksClean.append(line)


images=re.findall(r'function _setImagesSrc(.*?)</script>',str(file))
imagesStr=images[0]
imagesList=imagesStr.split('();(function(){var')
imagesClean=[]
count=0

for x in range(len(imagesList)):
    line=imagesList[x]
    start=line.find("s='")
    line=line[start+3:]
    end=line.find('setImagesSrc(ii,s);})();')
    line=line[:end-41]
    if(count<8):
        imagesClean.append(line)
        count+=1


jsonData=[]

for x in range(len(titlesClean)):
    jsonElement={'name':'','extension':'','link':'','image':''}
    jsonElement.update({'name':titlesClean[x]})
    jsonElement.update({'extension':datesClean[x]})
    jsonElement.update({'link':linksClean[x]})
    if(x<=7):
        jsonElement.update({'image':imagesClean[x]})
    else:
        jsonElement.update({'image':None})
    jsonData.append(jsonElement)


with open('data.json','w',encoding='utf-8')as f:
    json.dump(jsonData,f,ensure_ascii=False,indent=4)














    
