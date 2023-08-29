import requests
from html.parser import HTMLParser
from bs4 import BeautifulSoup

url = "https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html"

def main():
    paintings = []
    parseObject = parseHtml(url)
    pictures = parseObject.find_all()
    # find everything with "title" in line 65 and then add to

    return paintings


def parseHtml(url):
    webpage_text = requests.get(url).text
    soup = BeautifulSoup(webpage_text, 'html.parser')
    return soup

def findPaintingAttributes():
    painting_details = {}
    painting_details["name"] = "insert here" # title before "("
    painting_details["extensions"] = "insert here" # title regex "(...)"
    painting_details["link"] = "insert here" # href
    painting_details["image"] = "insert here" # src



    return painting_details



if __name__ == "__main__":
    main()
