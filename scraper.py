from bs4 import BeautifulSoup


def scrape_paintings_data(artist):
    # Use provided Van Gogh file else make http request to google
    if artist == 'Van Gogh':
        # Use local file provided for test
        with open('files/van-gogh-paintings.html',
                  'r') as file:
            page = file.read()
    else:
        return None
    # TODO: Update google tags for live app

    # Painting objects have the same tags save this to be easily updated incase google changes
    painting_tag = 'klitem'
    painting_name_tag = 'kltat'
    painting_extension_tag = 'klmeta'
    painting_image_tag = 'klic'

    google_base_url = 'https://www.google.com'

    # Parse HTML page using beautiful soup
    soup = BeautifulSoup(page, 'html.parser')

    # Use list comprehension to loop through paintings
    paintings = [
        {
            'name': ''.join(
                span.text for span in painting.find(class_=painting_name_tag).find_all('span')) if painting.find(
                class_=painting_name_tag) else None,
            'extensions': [painting.find(class_=painting_extension_tag).text if painting.find(
                class_=painting_extension_tag) else None],
            'link': google_base_url + painting['href'] if painting['href'] else None,
            'image': painting.find(class_=painting_image_tag).find('img').get('src')
        }
        for painting in soup.find_all(class_=painting_tag)
    ]

    return {"artworks": paintings}
