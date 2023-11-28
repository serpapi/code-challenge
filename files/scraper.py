from bs4 import BeautifulSoup as Soup


def parse_google_carousel(html_file):
    # Parse HTML file with BeautifulSoup to provide searching by tag/class
    file = open(f"./{html_file}", "r")
    html_soup = Soup(file.read(), features="html.parser")

    # Filtering by common class "klitem"
    carousel_items = html_soup.find("g-scrolling-carousel").find_all("a", {"class": "klitem"})


    # Creating empty array
    artworks = []


    for item in carousel_items:
        # The date will be in a div with class klmeta
        date_div = item.find("div", {"class": "klmeta"})

        # What to do if date is not present
        date = "" if not date_div else date_div.text

        list_item = {
            "name" : item.get("aria-label"),
            "extentions" : [date],
            "link" : f"https://www.google.com/{item.get('href')}",
            "image" : item.find("img").get("src")
        }

        artworks.append(list_item)

    return artworks
