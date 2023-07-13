from bs4 import BeautifulSoup
import json
from urllib.parse import urljoin

# Read the HTML file
with open('van-gogh-paintings.html', 'r') as file:
    html_content = file.read()

# Parse the HTML
soup = BeautifulSoup(html_content, 'html.parser')

# Find the container elements that hold the paintings
painting_containers = soup.find_all('a', class_='klitem')

# Initialize the list to store the extracted data
artworks = []

# Extract the JavaScript code containing the image value
script_tag = soup.find('script', text=lambda x: 'var s=' in x)
if script_tag:
    script_text = script_tag.text
    image_value = script_text.split("var s='", 1)[1].split("';var ii=['kximg0']", 1)[0]

    # Extract information for each painting
    for container in painting_containers:
        # Extract the name
        name = container['aria-label']

        # Extract the extensions
        extensions = container.find('div', class_='ellip klmeta')
        extensions_text = extensions.text.strip() if extensions else None

        # Extract the relative link
        relative_link = container['href']

        # Prepend the base URL to the relative link
        base_url = 'https://www.google.com'
        link = urljoin(base_url, relative_link)

        # Create a dictionary for the painting
        artwork = {
            'name': name,
            'link': link,
            'image': image_value
        }
        
        # Insert extensions at the correct position if not empty
        if extensions_text:
            artwork = {
                'name': artwork['name'],
                'extensions': [extensions_text],
                'link': artwork['link'],
                'image': artwork['image']
            }

        # Add the painting to the list
        artworks.append(artwork)

    # Save the data to a JSON file
    with open('extract-array.json', 'w') as json_file:
        json.dump(artworks, json_file, indent=4)
else:
    print("JavaScript containing the image value not found in the HTML.")
