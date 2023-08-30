import requests
from html.parser import HTMLParser
from bs4 import BeautifulSoup
import re

url = "https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html"

def main():
    paintings = []
    parseObject = parseHtml(url)
    pictures = parseObject.find_all("a class=\"klitem\"")
    images = parseObject.find_all("function(){var s")
    imageCounter = 0
    for picture in pictures:
        painting_details = {}
        painting_details["name"] = getPaintingName(picture)
        painting_details["extensions"] = getPaintingExtension(picture)
        painting_details["link"] = getPaintingLink(picture)
        if imageCounter < len(images):
            painting_details["image"] = images[imageCounter]
            imageCounter += 1
        else:
            painting_details["image"] = null
        paintings.append(painting_details)
    return paintings


def parseHtml(url):
    webpage_text = requests.get(url).text
    soup = BeautifulSoup(webpage_text, 'html.parser')
    return soup


def getPaintingName(picture):
    """
    Parse for title before "("
    """
    title = re.findall(r'title=([^"\d])"', picture).strip()
    return title


def getPaintingExtension(picture):
    """
    Parse for title between the (...)
    """
    title = re.findall(r'title=([^"]*)"', picture).strip()
    year = re.findall(r'\d+', title)
    return year


def getPaintingLink(picture):
    """
    Parse for href and add "www.google.com" to the front
    """
    search_link = re.findall(r'href=([^ ]+)')
    full_link = "www.google.com" + search_link
    return full_link



if __name__ == "__main__":
    main()
