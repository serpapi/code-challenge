from serpapi import GoogleSearch
import json

#initializing the output array
output = []

#search parameters sent to Serp API to pull the data
params = {
  "q": "Van Gough paintings",
  "location": "Austin, Texas, United States",
  "google_domain": "google.com",
  "hl": "en",
  "gl": "us",
  "api_key": "75eba2d2e783e1d5c605e14f9b6f9a031d23d4e1f92e5ca910ac49360876058e"
}

#search is executed and stored into results variable
search = GoogleSearch(params)
results = search.get_dict()

#extracted data from nested JSON object
# source: https://ankushkunwar7777.medium.com/get-data-from-large-nested-json-file-cf1146aa8c9e
def item_generator(json_input, lookup_key):
    if isinstance(json_input, dict):
        for k, v in json_input.items():
            if k == lookup_key:
                yield v
            else:
                yield from item_generator(v, lookup_key)
    elif isinstance(json_input, list):
        for item in json_input:
            yield from item_generator(item, lookup_key)

#appending the output for each result in the item_generator function
# source: https://ankushkunwar7777.medium.com/get-data-from-large-nested-json-file-cf1146aa8c9e
for i in item_generator(results, "artworks"):
    ans = {"artworks": i}
    output.append(ans)

#print the output
print(output)

#invoking the function 
knowledge_graph = item_generator(results, "knowledge_graph")

