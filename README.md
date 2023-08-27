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


## Notes from Hamilton on the Project

I kept the project as lightweight as possible in order to faciliate development speed. Obviously in a production environment this would would
live inside a more robust server platform system, including database backing, APIs for access, and a robustly defined core Class

A note: it looks like Google's search results may have changed since this project started? The search carousel I was receiving were more complex and varied than the one provided in the test data. I assumed that since the modern stuff didn't match the test data, we weren't expected to serve that use case, but it also made it hard to test the robustness and resiliency of my solution, since there wasn't really any comparison data to utilize.

I didn't add any options for configuring different input files or even being able to make live search queries, but that would probably be my next big step.

To use the project from the command line, just clone the repo and run
```
ruby lib/main.rb
```
from root.

Output is currently just dumping the JSON straight to console, since an output mechanism wasn't explicitily stipulated.