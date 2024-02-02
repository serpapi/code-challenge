from bs4 import BeautifulSoup
import re

FILE_NAME="files/van-gogh-paintings.html"

def extract_from_html(file_name=FILE_NAME):

    with open(file_name) as fp:
        soup = BeautifulSoup(fp, 'html.parser')

    res = soup.find_all("a", {"class": "klitem"})

    infos = []
    
    for item in res:

        info = {}
        title = item["title"]
        
        if '(' in title:
            info["title"] = item["title"].split('(')[0].strip()
            info["year"] = item["title"].split('(')[1]
        else:
            info["title"] = item["title"]
            info["year"] = None
            
        infos.append(info)

    for item in infos:
        if item["year"]:
            item["year"] = item["year"][:-1]

    return {
        "artworks": [
            {
                "name": work["title"],
                "extensions": [
                    work["year"],
                ],
            }
                for work in infos],
    }
