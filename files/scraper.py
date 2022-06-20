import re
import json

# open and read the html file
fname = r"van-gogh-paintings.html"
html_file = open(fname, 'r')
data = html_file.read()

# get each div with class 'klitem'
matches = re.findall(r'<a class="klitem".*?</div></div></a></div>', data)

# initiate output dict
art_dict = {"artworks": []}

for match in matches:
    # initate match dict
    match_dict = {}

    # get raw title data
    try:
        title = re.findall(r'title=".*?" ', match)
        # remove unwanted leading and trailing characters
        title = re.sub(r'title="', '', title[0])
        title = re.sub(r' \(.*?"', '', title)
        match_dict['name'] = title
    except:
        continue

    # get raw extensions data
    try:
        extensions = re.findall(r'<div class="ellip klmeta">.*?</div>', match)
        # get just the four digit year value
        year = re.search(r'[0-9]{4}', extensions[0])
        match_dict['extensions'] = [year.group()]
    except:
        continue

    # get raw link data
    try:
        link = re.findall(r'href="/search.*?" style=', match)
        # remove unwanted trailing characters
        link = re.sub(r'" style=', '', link[0])
        # replace href with google to complete url
        link = re.sub(r'href="', 'https://www.google.com', link)
        match_dict['link'] = link
    except:
        continue

    # get raw image data
    try:
        image = re.search(r'<img data-key=.*?id=".*?" src=', match)
        image = image.group().split(' ')[2]
        imgtag = image.split('"')[1]
        # locate second occurrence of imgtag where image loaded using JS
        image = re.search(r"'" + imgtag + r"'.*?;var ", data)
        # remove unwanted leading and trailing characters
        image = image[0].split("var s='")[1]
        image = re.sub(r"';var ", '', image)
        match_dict['image'] = image
    except:
        continue

    # append match_dict to art_dict
    art_dict['artworks'].append(match_dict)

output = json.dumps(art_dict, indent=2)
output = re.sub(r'^{\n(\s+)', '', output)
output = re.sub(r'}$', '', output)
print(output)

# write json to file
jsonFile = open("output.json", "w")
jsonFile.write(output)
jsonFile.close()

# make sure to close the file!
html_file.close()
