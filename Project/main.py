from bs4 import BeautifulSoup
import json

html_file = "vangogh.html"
with open(html_file, 'r', encoding='utf-8') as file:
    html = file.read()

soup = BeautifulSoup(html, 'html.parser')

items = soup.find_all('a', class_='klitem')

arts = []
temp_number = 0

for item in items:
    artwork = {}

    artwork["name"] = item.get('aria-label', 'none')

    date = item.find('div', class_='ellip klmeta')
    artwork["extensions"] = [date.text.strip() if date else "None"]

    link = "https://www.google.com" + item.get('href', '')
    artwork["link"] = link

    temp = 'kximg' + str(temp_number)
    base = soup.find('img', id=temp)
    if base and base.has_attr('src'):
        image_data = base['src'].split('base64,')[1]
        artwork["image"] = "data:image/jpeg;base64," + image_data

    arts.append(artwork)
    temp_number =+ 1

data = {"artworks": arts}
json_file = "data.json"
with open(json_file, 'w') as outfile:
    json.dump(data, outfile, indent=2)

print(f"scrapped into {json_file} success!!!")