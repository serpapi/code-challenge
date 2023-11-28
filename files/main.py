from scraper import parse_google_carousel

# 
results_array = parse_google_carousel("van-gogh-paintings.html")

# Write the returned array to a file in the /files directory
with open('./results.json', mode='wt', encoding='utf-8') as results:
    results.write('\n'.join(str(line) for line in results_array))
