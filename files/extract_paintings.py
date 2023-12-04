from bs4 import BeautifulSoup
import os
import json

# Get the absolute path of the current directory
current_directory = os.path.dirname(os.path.abspath(__file__))

# Construct the file path to the HTML file within the 'files' folder
html_file = os.path.join(current_directory, 'van-gogh-paintings.html')


# Open the file in read mode
with open(html_file, 'r') as f:

# Read the contents of the file 
    contents = f.read()

# Create a BeautifulSoup object
    soup = BeautifulSoup(contents, 'lxml')

# Extract painting titles 
    painting_titles = [element.get('title', '') for element in soup.find_all('a', class_='klitem', attrs={'title': True})]



# Extract painting dates from painting_titles
    dates = []
    for title in painting_titles:
        start = title.find('(')
        end = title.find(')')
        if start != -1 and end != -1:
            dates.append(title[start+1:end])
        else:
            dates.append('')
    #print(dates)

# Extract painting links
    painting_links = [element.get('href', '') for element in soup.find_all('a', class_='klitem', attrs={'href': True})]
    # Append the domain name to the links
    painting_links = ['https://www.google.com' + link for link in painting_links]
    #print(painting_links)

# Extract painintg images
    painting_images = soup.find_all('img', {'data-key': True})

# Extract the image links
    image_urls = [img['data-key'] for img in painting_images]
    #print(image_urls)

# Combine all data into one list
    paintings = []
    for i in range(len(painting_titles)):
        paintings.append({
            'name': painting_titles[i],
            'extensions': dates[i],
            'link': painting_links[i],
            'image': image_urls[i] if i < len(image_urls) else 'Null'
        })
    #print(json.dumps(paintings, indent=2))

# Add new key of 'paintings' to the dictionary
    paintings = {'paintings': paintings}
    #print(json.dumps(paintings, indent=2))


# Save to JSON file
    json_file = os.path.join(current_directory, 'paintings.json')
    try:
        with open(json_file, 'w') as f:
            json.dump(paintings, f, indent=2)
        print('File saved successfully!')
    except Exception as e:
        print(f'File not saved! Error: {e}')