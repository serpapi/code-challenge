## Enter any artists name and thi script will extract html ifle, sample json file of paintings

This script is parsing html and extracting carousel data from google with Selenium in Python.

There was a challenge since my carousel looks a bit different when I search for artist name + painter (or is it even a carousel) from the one from the challenge, I am not sure if it is a regional difference by Google or something else (I didn't use VPN).

So, additionally this script will prompt you to enter the painter's name.

Then it will go ahead search for that painter with query "painter name + paintings" and parse that html page, store it in file raw_file.html, next it will extract names of the paintings from the list, image link and year to separate json file data.json

It is locating and extracting data by class names that I found for each attribute.

In next iterations I would find a way to search and extract carousel data easier, and target the exact carousel. 
I see now the value for using SerpAPI that you can use specific localization, advanced filters and use knowledge graph with exact granularity. It makes the whole process seamless and easy.

Hope you liked my approach.





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
