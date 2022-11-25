# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](./files/screenshots/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready.
Do not use more than 4 hours of your time.

Programming language wise, Ruby is suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: ./files/van-gogh-paintings.json
[html file]: ./files/search-results/van-gogh-paintings.html
[expected array]: ./files/expected-array/van-gogh-paintings.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed).

Test against 2 other similar result pages. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)
