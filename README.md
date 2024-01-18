# Updated Information

This challenge was developed a few years ago and utilizes a carousel that I'm having difficulty replicating on Google at this time. I thought to look back for other users' .html files that would have the correct carousel, but I ended up spoiling myself onto the solutions/tricks and I felt that the challenge was rendered ineffective.

I have included a simplified solution of the original prompt - however a majority of the solution is just a rehashed version of [This Solution](https://github.com/marm123/code-challenge/tree/master) from a few years ago. I originally approached this project a few different ways, but none felt as functional/elegant as this solution.

## Additional Scraping
Due to the dated nature of the original challenge, and the fact that I had in a way "spoiled" the solution for myself, I decided to take on an 'updated' challenge, and try to use similar methods to scrape a different part of google's search.

### What?
While searching different topics, I noticed that this "Top X" drop-down would be a decent example.
This example serves a similar purpose of the carousel and has many pages that it can be tested against for repeatability.

![Nfl Top Athletes]([files\top-athlete-example.png](https://github.com/kozeee/SerpApi_Code_Challenge/blob/master/files/top-athlete-example.png))

### Solution

First, I noted that the panel has two tags that isolate it from the rest of the page (`data-ipr` and `data-vmt`). These may denote the amount of rows, and total amount of items displayed? Either way, these two values are only found in the panel we're looking to scrape, so we start here.

From this point I drill down into the aspects of what I want based on data tags. The name of each item (usually a person) can be found with the `data-entityname` tag, and the description or "read more" text can be found with the `data-attrid` tag. 

Conveniently, each item also contains a google link to the specific item (again, usually a person.). Because we have isolated our `topLevel` soup to the panel we can search for anchor tags that specifically have a `g-raised-button` tag as a child node, which will be our google link.

Finally, we look for our additional data - this is usually a date, or team name, or some kind of secondary identifier to the main item. For this, I've elected to use findNextSibling as it seems to always be structured in the div directly under the one where we find our name.

Admittedly some of this solution is flimsy and may be prone to breakage, but I feel that it achieved decent results considering the time I allotted myself and my limited knowledge of webscraping when I began the project.




# Extract Van Gogh Paintings Code Challenge (Original Challenge)

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
