from bs4 import BeautifulSoup
import json

def read_html_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    return content

def parse_html(html_content):
    return BeautifulSoup(html_content, 'html.parser')

def extract_paintings(soup):
    paintings = []

    for item in soup.select('.iELo6'):
        title_element = item.select_one('.pgNMRc')
        link_element = item.select_one('a')
        date_element = item.select_one('.cxzHyb')
        thumbnail_element = item.select_one('img.taFZJe')

        title = title_element.get_text(strip=True) if title_element else None
        link = link_element['href'] if link_element else None
        date = date_element.get_text(strip=True) if date_element else None
        thumbnail = thumbnail_element['src'] if thumbnail_element else None

        if title and link:
            painting_info = {
                'name': title,
                'extensions': [date] if date else [],
                'link': link,
                'thumbnail': thumbnail
            }
            paintings.append(painting_info)

    return paintings

def extract_paintings_from_file(file_path):
    html_content = read_html_file(file_path)
    soup = parse_html(html_content)
    return extract_paintings(soup)

def format_data(paintings):
    return json.dumps({"artworks": paintings}, indent=2)

def write_to_json_file(data, output_path):
    with open(output_path, 'w', encoding='utf-8') as file:
        file.write(data)

def main():
    input_path = 'files/van-gogh-paintings.html'
    output_path = 'files/extracted-paintings.json'

    html_content = read_html_file(input_path)
    soup = parse_html(html_content)
    paintings = extract_paintings(soup)
    formatted_data = format_data(paintings)
    write_to_json_file(formatted_data, output_path)

    print(f"Extracted data written to {output_path}")

if __name__ == "__main__":
    main()