from bs4 import BeautifulSoup

file = open("../files/van-gogh-paintings.html", "r")

content = file.read();

html = BeautifulSoup(content,"lxml")

images = html.select("g-scrolling-carousel a.klitem")

artworks_collections = []
for item in images:
    label = item.get("aria-label")
    href =  item.get("href")

    extensions_element = item.select_one(".klmeta")
    extensions = extensions_element.string if extensions_element is not None else ""

    image_data = item.select_one("img").get("src")

    artwork_object = {
        "name": label,
        "extensions": [
            extensions
        ],
        "link": "https://www.google.com" + href,
        "image": image_data
    }
    artworks_collections.append(artwork_object)

artworks = {
    "artworks": artworks_collections
}

print(artworks)
