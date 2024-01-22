import re
from bs4 import BeautifulSoup

# I've written <100 lines of python code in total and have never scraped web pages so we'll see how things go here. 

path = 'files/van-gogh-paintings.html'

with open(path,'r',encoding='utf-8') as file: 
    html = file.read()

soup = BeautifulSoup(html,'html.parser')

# we'll come back to this part in our function later to find the thumbnail
script_tags = soup.find_all('script') 

def extract_thumbnail_with_id(id):
        extracted_value = None
        pattern = re.compile(r"var s='([^']+)';") # match on any character that's not a single quote '
        for script in script_tags: 
            if script.string: 
                match = pattern.search(script.string)
                if match: 
                    extracted_value = match.group(1) # grab s 
                    break
        return extracted_value

# referencing https://beautiful-soup-4.readthedocs.io/en/latest/#searching-the-tree
# found klitem as class for carousel objects using browser inspect 

data = [] 
for item in soup.find_all('a',class_='klitem'):
    # href only has subdomain + query parameters, add domain 
    link = 'https://www.google.com' + item['href']

    # title 'lives' in two spots, one has year appended, which we would rather have the discrete value of so we'll pull title out of here and clean it up
    kltat_divs = item.find_all('div',class_='kltat')
    title = kltat_divs[0].get_text() if kltat_divs else None 

    # repeat for year in separate class
    klmeta_divs = item.find_all('div',class_='ellip klmeta')
    year = klmeta_divs[0].get_text() if klmeta_divs else None 

    # hey look someone wrote a blog post: https://serpapi.com/blog/scrape-google-carousel-results-with-python/ 
    # let's follow that, but try to get it to work with our beautiful approach

    tb_ =  item.select_one(".klzc > .klic > .BA0A6c").find_all('img',class_='rISBZc M4dUYb')
    tb_id = tb_[0]['id'] if tb_ else None 

    thumbnail = extract_thumbnail_with_id(tb_id)

    data.append({
        'link': link,
        'title': title,
        'year': year,
        'thumbnail':thumbnail
    })

# no time to polish up the actual delliverable portion of this - print will have to do. 
print(data) 
