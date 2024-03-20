# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready.

Programming language wise, Ruby (with RSpec tests) is strongly suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages to make sure it works against different layouts. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

The suggested time for this challenge is 4 hours. But, you can take your time and work more on it if you want.

## Code Challenge

### Overview of files

Added to this PR is both a Python and Ruby solution to the challenge. Python is the language I'm
most comfortable in and have used BeautifulSoup many times before scraping. I
had wanted to try my hand at writing the solution in Ruby even though I had
never previously used the language. 

Each solution folder contains the script used to generate the data.json file
containing the scraped data from the google images carousel. The
example-webpages used here contains the additional test webpages I used along
with all their assets. The Python solution can be provided the absolute file path and
output file name as program arguments (respectively) while the Ruby solution
would require hardcoding the absolute file path in the file itself. Below is a
list of requirements needed to run both requirements

<pre><code>
Python requirements
-------------------
Selenium
BeautifulSoup
json
sys
re

Ruby requirements
-----------------
Selenium
Nokogiri
json

</code></pre>

### Overview of solution
Both solutions utilize the same approach in loading the local html file with the
selenium webdriver. Then each script will locate the g-scrolling-carousel
element by tag name and get the list of child anchor tags. From this list of
anchor tags we are able to extract all the necessary information through
attributes of the tag itself. I had added simple checks to see if certain
features such as the date or img source were included to decide whether to
include those fields into the json data.

### Approach to challenge

For this challenge before writing any code I opened up the van gogh html file in
chrome developer tools to inspect the DOM structure. Once I had a general idea
of what tags I needed to be looking for I then used Python's interactive
interpreter in order to start scraping. I found it faster to test scraping ideas
this way as opposed to repeatedly making changes to a separate script. Once I
was able to obtain the data I needed through the interpreter and write the json
array to a file I then copied the relevant code in the interpreter into the
googleImgScraper.py script and refactored the code into separate functions. Then
ran the script on the additional webpages to ensure I was able to extract the
same data.
After I was sure the script was working, I started installing Ruby and
wrangling the libraries I needed (i.e. get Nokogiri working). Once I had Ruby,
RVM, and JRuby setup I used the overall same logic in the Ruby script with
Nokogiri and was able to write the same data to a json file.

While I was developing I had noticed I would need
selenium in order to load the proper img base64 data otherwise it wouldn't
contain the same data that was shown in the expected solution. Overall I enjoyed
working on this challenge as I haven't had a chance to play around with web
scraping in some time. 
