# import for parsing HTML
from bs4 import BeautifulSoup
# import to save output as a JSON file
import json


# open the HTML file and read the contents
with open("van-gogh-paintings.html", "r", encoding="utf-8") as file:
    content = file.read()

# tells python how to interpret the HTML
soup = BeautifulSoup(content, "html.parser")

# find all elements with class "iELo6"
# each represents a specific painting
paintings = soup.find_all(class_ = "iELo6")

# empty list to store all painting data
paintings_data = []

# loop through each painting element
for painting in paintings:

    # extract the relevant information and store as a dictionary
    paintings_data.append({
        # get the name of the painting from <img alt>
        "name": painting.find('img').get('alt'),
        # get the extensions (year) from the <div class_="cxzHyb">
        "extensions": [painting.find("div", class_="cxzHyb").get_text(strip=True)],
        # get the link from the <a href>
        "link": "https://www.google.com" + painting.find('a').get('href'),
        # get the image source from <img src>
        "image": painting.find('img').get("data-src") or painting.find('img').get("src")
    })

# wrap list of paintings inside a dictionary with the key "artworks"
final_paintings_data = {
    "artworks": paintings_data
}

# write data into a JSON file
# ensure_ascii=False so characters like é are kept
with open("paintings_challenge.json", "w", encoding="utf-8") as f:
    json.dump(final_paintings_data, f, indent=2, ensure_ascii=False)


# added comments so that I can look back and easily remember how to use Beautiful Soup
# the 2 differences between my paintings_challenge.json and the expected-array.json
    # the image links are "data:image/gif;base64" instead of "data:image/jpeg;base64" for the first few objects
    # the edge case where "Sunflowers" does not have a year