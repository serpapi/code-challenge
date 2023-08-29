import requests
from html.parser import HTMLParser
from bs4 import BeautifulSoup

url = "van-gogh-paintings.html"

def main():
    paintings = []
    parseObject = parseHtml(url)


    return paintings


def parseHtml(url):
    webpage_text = requests.get(url).text
    soup = BeautifulSoup(webpage_text, 'html.parser')
    return soup




if __name__ == "__main__":
    main()
