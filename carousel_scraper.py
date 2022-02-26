import json
import re
from bs4 import BeautifulSoup
from itertools import zip_longest
from sys import argv

def try_add(dct, key, element, prop="text"):
    """
    Attempts adding a key to a dictionary
    extracted from element as element[prop]
    or element.prop, if either prop exists
    on element
    """
    try:
        dct[key] = element[prop]
    except KeyError:
        dct[key] = getattr(element, prop)
    except (KeyError, AttributeError, TypeError):
        ...

def scrape_google_carousel(html, root_href):
    """ Scrapes data from the Google image search result carousel """
    soup = BeautifulSoup(html, "lxml")
    result = {"artworks": []}
    images = [
        x[7:].replace(r"\x3d", "x3d")
        for x in re.findall(r"var s='data:image/jpeg;base64,[^']+", str(soup))
    ]
    cards = soup.select(".EDblX .MiPcId")

    for image, card in zip_longest(images[:len(cards)], cards):
        data = {}
        result["artworks"].append(data)
        try_add(data, "name", card.select_one(".kltat"))
        try_add(data, "extensions", card.select_one(".ellip.klmeta"))
        try_add(data, "link", card.select_one('a[role="button"]'), prop="href")
        try_add(data, "image", card.select_one("g-img img.rISBZc.M4dUYb"), prop="src")
    
        if "extensions" in data:
            data["extensions"] = [data["extensions"]]
    
        if "link" in data:
            data["link"] = root_href + data["link"]

        if "image" in data and data["image"] is not None:
            data["image"] = image

    return result

if __name__ == "__main__":
    filename = argv[1] if len(argv) > 1 else "files/van-gogh-paintings.html"

    with open(filename) as f:
        html = f.read()

    root_href = "https://www.google.com"
    data = scrape_google_carousel(html, root_href)

    with open("actual.json", "w", encoding="utf-8") as fh:
        json.dump(data, fh, ensure_ascii=False, indent=2)

