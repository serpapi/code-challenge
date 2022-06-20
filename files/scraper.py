import re

# open and read the html file
fname = r"van-gogh-paintings.html"
html_file = open(fname, 'r')
data = html_file.read()

# get each div with class 'klitem'
matches = re.findall(r'<a class="klitem".*?</div></div></a></div>', data)

for match in matches:
    # get raw title data
    try:
        title = re.findall(r'title=".*?" ', match)
        # remove unwanted leading and trailing characters
        title = re.sub(r'title="', '', title[0])
        title = re.sub(r' \(.*?"', '', title)
        print(title)
    except:
        continue


# make sure to close the file!
html_file.close()
