"""
Sean Ryan
Customer Success Engineer applicant
Extract Van Gogh Paintings Code Challenge

This is a function to isolate resutls from a google search image carousel, parse out information, and return an array 
"""

from bs4 import BeautifulSoup as Soup


def parse_google_carousel(html_file):
    # Parse HTML file with BeautifulSoup to provide searching by tag/class
    file = open(f"./files/{html_file}", "r")
    html_soup = Soup(file.read(), features="html.parser")
    
    # Individual results will be within the g-scrolling-carousel tag and have an anchor class 'klitem'
    carousel_items = html_soup.find("g-scrolling-carousel").find_all("a", {"class": "klitem"})
    

    # Create empty list to store results
    artworks = []
    
    
    for item in carousel_items:
        # The date will be in a div with class klmeta
        date_div = item.find("div", {"class": "klmeta"})
        
        # Handle interations where the date is not present
        date = "" if not date_div else date_div.text
        
        list_item = {
            "name" : item.get("aria-label"),
            "extentions" : [date],
            "link" : f"https://www.google.com/{item.get('href')}",
            "image" : item.find("img").get("src")
        }
         
        artworks.append(list_item)
    
    return artworks

