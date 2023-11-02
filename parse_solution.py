from bs4 import BeautifulSoup
import re
import json


def ParseGoogleHTML():

    # Read HTML File
    with open("files\\van-gogh-paintings.html") as f:
        html_file = f.read()

    # Create Empty Artworks array
    image_array = {'artworks': []}

    # Create Beautiful Soup Object
    html_raw = BeautifulSoup(html_file, 'html')

    # Pull out carousel from html_raw
    carousel = html_raw.find('g-scrolling-carousel')

    # Get thumbnail data by extracting script
    scripts = html_raw.find_all('script')
    for script in scripts:
        # Look for function used with thumbnails
        if 'function _setImagesSrc' in script.text:
            thumbnail_script = script.text
    # Regex to find thumbnail data string
    thumbnails = [tnail[3:-2] for tnail in re.findall(r"s='.*?';", thumbnail_script)]

    # Zip and loop through thumbnails and carousel items containing same class for image data
    for thumbnail, element in zip(thumbnails, carousel.find_all('a',attrs={'class':'klitem'})):
        # Append each image to image array
        image_array['artworks'].append({'name': element.get('aria-label'),
                                        'extensions': [meta.text for meta in element.find_all('div', attrs={'class': 'ellip klmeta'})],
                                        'link': "https://www.google.com" + element.get('href'),
                                        'image': thumbnail})
    # Write Output File
    with open("files\\result.json", "w") as outfile:
        outfile.write(json.dumps(image_array))

ParseGoogleHTML()
