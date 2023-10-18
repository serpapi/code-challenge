"""
Sean Ryan
Customer Success Engineer applicant
Extract Van Gogh Paintings Code Challenge

This script will parse the Van Gogh search resutls HTML file and write the expected array to files/results.json

BeautifulSoup is required to run the script locally
https://pypi.org/project/beautifulsoup4/
"""

from google_carousel_scrapper import parse_google_carousel

# Call function to extract array from google search retults HTML
resutls_array = parse_google_carousel("van-gogh-paintings.html")

# Write the returned array to a file in the /files directory
with open('./files/results.json', mode='wt', encoding='utf-8') as results:
    results.write('\n'.join(str(line) for line in resutls_array))
    
    
