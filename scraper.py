# Import JSON to export artworks as JSON and BeautifulSoup to help parse HTML
import json
from bs4 import BeautifulSoup

def parser():
  # Read given Van Gogh Painting HTML file and parse with BeautifulSoup
  HTMLfile = open("././files/van-gogh-paintings.html","r")
  page = HTMLfile.read()
  soup = BeautifulSoup(page, "html.parser")

  # Find the carrousal element by class and find individual painting elements within carrousal
  results = soup.find("div", class_="klbar")
  image_elements = results.find_all("a",class_="klitem")

  # Initialize artworks array to hold all painting objects
  artworks = []

  # Loop over each painting in the carrousal and find the name, date, link, and image thumbnail
  for image_element in image_elements:
    title_element = image_element["title"]
    try: 
      name, date = title_element.split('(1')
      date = "1" + date.replace(")","")
      extensions = [date]
    except:
      name = title_element
      extensions = []
    link = "https://www.google.com" + image_element["href"]
    
    # Currently getting incorrect image, seems it is placeholder image instead of img src, needed to extract from script instead, but out of time
    image_element = image_element.find("div",class_="klic").find("g-img").find("img")
    try: 
      image = image_element["src"]
    except:
      image = "null"
    
    # Create artwork object including name, date if there is one, link, and image thumbnail if there is one and add to artworks array
    artwork = {}
    artwork["name"] = name
    if len(extensions) > 0:
      artwork["extensions"] = extensions
    artwork["link"] = link
    artwork["image"] = image
    artworks.append(artwork)

  # Create JSON object with artworks included
  json_object = json.dumps({"artworks":artworks}, indent=1)

  # Create sample.json file with all artworks included to see output result
  with open("sample.json","w") as outfile:
    outfile.write(json_object)

parser()