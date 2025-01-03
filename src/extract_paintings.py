from bs4 import BeautifulSoup

def extract_paintings(html_content):
    soup = BeautifulSoup(html_content, 'lxml')
    paintings = []

    # Extract painting information
    for item in soup.select('.g'):
        title = item.select_one('.title').get_text(strip=True)
        link = item.select_one('.link')['href']
        date = item.select_one('.date').get_text(strip=True) if item.select_one('.date') else None
        thumbnail = item.select_one('img')['src'] if item.select_one('img') else None

        painting_info = {
            'title': title,
            'link': link,
            'date': date,
            'thumbnail': thumbnail
        }
        paintings.append(painting_info)

    return paintings

# Usage example
with open('path_to_html.html', 'r', encoding='utf-8') as file:
    html_content = file.read()

paintings = extract_paintings(html_content)
for painting in paintings:
    print(painting)