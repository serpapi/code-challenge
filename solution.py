import json
from urllib.parse import urljoin

from bs4 import BeautifulSoup


def load_html_file(file_path):
    '''
    Load content of the HTML file.
    Input:
        file_path: path to the HTML file
    Output:
        html_raw: str
    '''
    with open(file_path, 'r') as fp:
        html_raw = fp.read()
    return html_raw


def extract_features(painting, script_tags):
    '''
    Parse painting data to extract all requested properties: name, link, extension, and image.
    Input:
        painting: individual painting data parsed from the Google image carousel
        script_tags: list, content of all <script> tags in the HTML file
    Output:
        dictionary containing 'name', 'link', 'extensions' (if found), and 'image' fields
    '''
    name = painting['aria-label']
    link = urljoin('https://www.google.com', painting['href'])
    extensions = painting.find('div', attrs='ellip klmeta')

    find_id_split = str(painting.find('g-img', attrs='BA0A6c').find('img', 'rISBZc M4dUYb')).split(" ")
    for s in find_id_split:
        if s.startswith('id='):
            id = s.split("=")[1]
    image = extract_thumbnail(script_tags, id)

    if extensions:    
        return {
                'name': name,
                'link': link,
                'extensions': [extensions.text],
                'image': image,
        }
    else:
        return {
                'name': name,
                'link': link,
                'image': image,
        }


def extract_thumbnail(data, image_id):
    '''
    Extracts the 'image' parameter from <script> tag, based on image_id.
    Input:
        data: list of contents of all <script> tags
        image_id: str, ID of the image
    Output:
        image_data: str
    '''
    for tag in data:
        if "kximg" in tag.text:
            image_script = tag.contents[0]
            break

    semicol_split_data = image_script.split(";")
    image_id = image_id.strip('"')

    for i in range(len(semicol_split_data)):
        if semicol_split_data[i].startswith(f"var ii=['{image_id}"):
            return semicol_split_data[i-2].split("'")[1] + semicol_split_data[i-1]
        else:
            return None


def main():
    html_raw = load_html_file('files/van-gogh-paintings.html')
    soup = BeautifulSoup(html_raw, 'html.parser')

    painting_carousel = soup.find_all('a', attrs='klitem')
    script_tags = soup.find_all('script')

    artwork = []

    for painting in painting_carousel:
        painting_data = extract_features(painting, script_tags)
        artwork.append(painting_data)

    with open('output.json', 'w+') as out_fp:
        json.dump(artwork, out_fp)


if __name__ == '__main__':
    main()