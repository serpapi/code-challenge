from bs4 import BeautifulSoup   # My HTML Parser of choice
import os   # To navigate the chosen raw html given for this challenge
import json # To output the dictionary to json

script_dir = os.path.dirname(os.path.abspath(__file__))

html_file_path = os.path.join(script_dir, '..', '..', 'files', 'van-gogh-paintings.html')

with open(html_file_path, 'r') as file:
    html_content = file.read()

# Parsing the HTML with Soup
soup = BeautifulSoup(html_content, 'html.parser')

# Export dictionary output as a json file
def export_file(results, file_name):
    print("Exporting paintings information")
    file_path = file_name + "_main_expected_output.json"

    with open(file_path, 'w') as jsonfile:
        json.dump(results, jsonfile, indent=2)

    print("Paintings information has been exported to ", file_path)


def extract_paintings_info(soup):
    # Find all painting title elements
    painting_title_elements = soup.find_all('div', class_='kltat')
    # Extract only the text content of titles
    painting_titles = [title.get_text(strip=True) for title in painting_title_elements]

    #Painting Dates
    painting_dates_elements = soup.find_all('div', class_ = 'ellip klmeta')
    painting_dates = [date.get_text(strip=True) for date in painting_dates_elements]

    # Paintings Google Link
    # Find all 'a' elements with class 'klitem'
    painting_link_elements = soup.find_all('a', class_='klitem')

    # Extract href attributes and store them in an array
    googleLink = "https://www.google.com"
    link_array = [googleLink + link_element.get('href', '') for link_element in painting_link_elements]

    # Extract img thumbnails
    painting_img_elements = soup.find_all('img', class_='rISBZc M4dUYb')
    img_array = [img_element.get('data-key', img_element.get('data-src', '')) for img_element in painting_img_elements]

    paintings_info = []

# Iterate over the elements of the arrays simultaneously
    for title, date, link, img in zip(painting_titles, painting_dates, link_array, img_array):
        # Store the information in a dictionary
        painting_info = {
            'name': title,
            'extensions': date,
            'link': link,
            'image': img
        }

        # Append the dictionary to the paintings_info list
        paintings_info.append(painting_info)

# Now, paintings_info contains a list of dictionaries with name, extensions, links and thumbnails 
    return paintings_info


# Main function that will format and export the files
if __name__ == '__main__':
    formatted_soup = extract_paintings_info(soup)
    export_file(formatted_soup, "van_Gogh_paintings")