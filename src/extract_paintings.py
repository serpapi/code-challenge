import os
from bs4 import BeautifulSoup
import json
import re

def read_html_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    return content

def parse_html(html_content):
    parsering = BeautifulSoup(html_content, 'html.parser')
    return parsering

def extract_paintings(soup):
    paintings = []

    base64_pattern = re.compile(r"data:image/jpeg;base64,[^\']+")

    for item in soup.select('.iELo6'):
        title_element = item.select_one('.pgNMRc')
        link_element = item.select_one('a')
        date_element = item.select_one('.cxzHyb')

        title = title_element.get_text(strip=True) if title_element else None
        link = "https://www.google.com" + link_element['href'] if link_element else None
        date = date_element.get_text(strip=True) if date_element else None

        script_tag = item.find_next('script', string=base64_pattern)
        thumbnail = base64_pattern.search(script_tag.text).group(0) if script_tag else None

        if title and link:
            painting_info = {
                'name': title,
                'extensions': [date] if date else [],
                'link': link,
                'image': thumbnail
            }
            paintings.append(painting_info)

    return paintings

def format_data(paintings):
    return json.dumps({"artworks": paintings}, indent=2)

def write_to_json_file(data, output_path):
    with open(output_path, 'w', encoding='utf-8') as file:
        file.write(data)

def input_path(default='files/van-gogh-paintings.html'):
    path = input(f"Enter input path [{default}]: ")
    return path if path.strip() else default

def main():
    try:
        input_path_value = input_path()
        if not os.path.exists(input_path_value):
            raise FileNotFoundError(f"File not found: {input_path_value}")

        output_path = 'files/extracted-paintings.json'

        html_content = read_html_file(input_path_value)
        soup = parse_html(html_content)
        paintings = extract_paintings(soup)
        formatted_data = format_data(paintings)
        write_to_json_file(formatted_data, output_path)

        print(f"Extracted data written to {output_path}")
    except FileNotFoundError as e:
        print(e)
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
    