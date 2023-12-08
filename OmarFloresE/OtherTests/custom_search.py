from bs4 import BeautifulSoup   # My HTML Parser of choice
import os   # To navigate the chosen raw html given for this challenge
import json # To output the dictionary to json
import requests # For testing out other Google Search Results.

#Export raw HTML into orangized HTML for my analysis
def export_html_file(results, file_name):
    print("Exporting prettified HTML File")
    file_path = file_name + "_test_output.html"

    results = results.prettify()

    with open(file_path, 'w') as htmlfile:
        htmlfile.write(results)

    print("Parsed Data has been formatted and exported to ", file_path)


# Export json file from the dictionary output
def export_json_file(results, file_name):
    print("Exporting paintings information")
    file_path = file_name + "_output_test_info.json"

    with open(file_path, 'w') as jsonfile:
        json.dump(results, jsonfile, indent=2)

    print("Query JSON information has been exported to ", file_path)


def extract_paintings_info(soup):
# Find all painting title elements
    painting_title_elements = soup.find_all('div', class_='BNeawe s3v9rd AP7Wnd')
    # Extract only the text content of titles
    painting_titles = [title.get_text(strip=True) for title in painting_title_elements]

    #Painting Dates
    painting_dates_elements = soup.find_all('div', class_ = 'BNeawe tAd8D AP7Wnd')
    painting_dates = [date.get_text(strip=True) for date in painting_dates_elements]

    # Paintings Google Link
    # Find all 'a' elements with class 'BVG0Nb'
    painting_link_elements = soup.find_all('a', class_='BVG0Nb')

    # Extract href attributes and store them in an array
    googleLink = "https://www.google.com"
    link_array = [googleLink + link_element.get('href', '') for link_element in painting_link_elements]

    # Extract img thumbnails 
    painting_img_elements = soup.find_all('img', class_='h1hFNe')
    img_array = [img_element.get('data-key', img_element.get('src', '')) for img_element in painting_img_elements]

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


# Function to define google search and return HTML
def define_search(query):
    
    url = 'https://google.com/search?q=' + query 
  
    # Get the URL data using requests.get(url), 
    # store it in a variable, request_result. 
    request_result=requests.get( url ) 

    soup = BeautifulSoup(request_result.text,"html.parser") 

    return soup
    


# Main function that will initiate query by user input, then format and export 
if __name__ == '__main__':

    search_query = input("Type in your favorite Artist: ")
    html_soup = define_search(search_query)

    export_html_file(html_soup, search_query)
    
    formatted_soup = extract_paintings_info(html_soup)
    export_json_file(formatted_soup, search_query)