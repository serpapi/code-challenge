import sys
from bs4 import BeautifulSoup
import json

def serp_scraper(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    soup = BeautifulSoup(content, 'html.parser')

    artworks = []
    paintings = soup.find_all('a', class_='klitem')

    # Check if the first set of classes is present
    if paintings:
        for painting in paintings:
            artwork = {}

            # Extract painting name
            name_element = painting.find('div', class_='kltat')
            artwork['name'] = name_element.get_text(strip=True)

            # Extract extensions (date)
            # extensions_element = painting.find('div', class_='ellip klmeta')
            # artwork['extensions'] = [extensions_element.get_text(strip=True)] if extensions_element else []

            #Extract extensions (date)
            extensions_element = painting.find('div', class_='ellip klmeta')
            if extensions_element:
                artwork['extensions'] = [extensions_element.get_text(strip=True)]
            else:
                artwork['extensions'] = []

            # Extract Google search link
            artwork['link'] = painting['href']

            # Extract image (thumbnail)
            image_element = painting.find('img', class_='rISBZc')
            artwork['image'] = image_element['src'] if image_element and 'src' in image_element.attrs else None

            artworks.append(artwork)
    else:
        # If the first set of classes is not found, try the second set
        paintings = soup.find_all('a', class_='ct5Ked klitem-tr PZPZlf')

        for painting in paintings:
            artwork = {}

            # Extract painting name
            name_element = painting.find('div', class_='FozYP')
            artwork['name'] = name_element.get_text(strip=True)

            # Extract extensions (date)

            extensions_element = painting.find('div', class_='FozYP', jsname=False)
            if extensions_element:
                year_text = extensions_element.get_text(strip=True)
                year = year_text if year_text.isdigit() else None
            else:
                year = None
            artwork['extensions'] = [year] if year else []

            # Extract Google search link
            artwork['link'] = painting['href']

            # Extract image (thumbnail)
            image_element = painting.find('g-img', class_='ZGomKf')
            artwork['image'] = image_element['src'] if image_element and 'src' in image_element.attrs else None

            artworks.append(artwork)

    return artworks

def main():
    if len(sys.argv) < 2:
        print("Please provide a file path as a command-line argument.")
        return

    file_path = sys.argv[1]
    artworks = serp_scraper(file_path)

    # Output the scraped data as JSON
    output = {"artworks": artworks}
    print(json.dumps(output, indent=4))

if __name__ == '__main__':
    main()
