from serpapi import GoogleSearch
import json
import requests
from bs4 import BeautifulSoup
import os


test_queries = ["Van Gogh paintings", "Banksy arts", "Picasso works"]
# Parameters used in the initial search
query = test_queries[0]
location = "Austin,Texas"
# Please provide your own secret API key
api_key = "<YOUR_SECRET_API_KEY>"

# Creating the search object, that is further exported to dictionary
search = GoogleSearch({
    "q": query, 
    "location": location,
    "api_key": api_key,
  })
search_result = search.get_dict()
# if search.get_response()


# Saving the RAW HTML file using requests module
url = search_result['search_metadata']['raw_html_file']
website = requests.get(url)
website_text = str(website.text)
with open('raw.html', 'w') as html:
    html.write(website_text)


# # Storing the search results in JSON file
search_result_json = json.dumps(search_result, indent=4)
with open('search_result.json', 'w') as initial_search:
    initial_search.write(search_result_json)


# # Navigating through obtained dict to fetch relevant artworks
knowledge_graph = search_result["knowledge_graph"]
artworks = knowledge_graph["artworks"]

# Replacing 'image' value with data:image from the html file
content = website.content
soup = BeautifulSoup(content, "html.parser")

for artwork in artworks:
    name = artwork["name"]
    result = soup.find(alt=name)
    image_data = result.get('src')
    artwork['image'] = image_data


# # Exporting the artworks to JSON
json_results = json.dumps(artworks, indent=4)
with open('final_results.json', 'w') as final_results:
    final_results.write(json_results)
