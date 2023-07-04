# SERPAPI-task
# Extract Van Gogh Paintings Code Challenge

## Prerequisites:
```
from serpapi import GoogleSearch
import json
import requests
from bs4 import BeautifulSoup
import os
```

## Make sure to update your API key!
```
# Please provide your own secret API key
api_key = "<YOUR_SECRET_API_KEY>"
```

## By default the code will extract Van Gogh paintings, however additional test scenarios has been added to test_queries array, that can be tested anytime:

```
test_queries = ["Van Gogh paintings", "Banksy arts", "Picasso works"]
# Parameters used in the initial search
query = test_queries[0]
```

## As a result, script will create 3 additional files:
```
1. search_result.json - full search results in JSON format
2. raw.html - raw HTML file of the search results website
3. final_results.json - purpose of this challenge - extracted painting's name, year, link and thumbnail in JSON format
```

