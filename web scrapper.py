from bs4 import BeautifulSoup
import re
import json
import os

for file in os.listdir('test_files'):
    with open(f'test_files/{file}', encoding='utf-8') as url:
        soup = BeautifulSoup(url, 'html.parser')

        results = {
            'artworks': []
        }

        for tag in soup.find('g-scrolling-carousel'):

            titles = tag.findAll('a')
            for element in titles:
                name = element['aria-label']
                extensions = []
                link_extension = element['href']
                link = 'google.com' + link_extension
                thumbnail_source = element.find('img')
                try:
                    if thumbnail_source is not None:
                        image_id = thumbnail_source['id']
                        thumbnail = thumbnail_source['src']
                        for script in soup.findAll('script'):
                            images = re.findall(rf"(?<=var s=')(.*?)(?=';var ii=\['{image_id}'])", str(script))
                            if images:
                                decoded_image = images[0].encode('ascii', 'ignore')
                                decoded_image = decoded_image.decode('unicode-escape')
                                thumbnail = decoded_image
                    else:
                        thumbnail = None
                except KeyError:
                    thumbnail = None
                if element.findAll('div') and element.findAll('div')[-1].text != name:
                    extensions.append(element.findAll('div')[-1].text)

                results['artworks'].append({
                    'name': name,
                    'extensions': extensions,
                    'link': link,
                    'thumbnail': thumbnail
                })

    json_file = json.dumps(results, indent=4)
    with open(f'result_files/{file}'.replace('.html', '.json'), 'w') as output:
        output.write(json_file)
