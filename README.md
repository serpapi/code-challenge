# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Dependencies

It requires the nokogiri and rspec gems

## How to run

To run the spec, run `rspec paintings_spec.rb`. It will run tests for 3 painters (Van Gogh, Monet and Michelangelo)

You can also parse a sample html file and see the full JSON in standard output. For instance `ruby challenge.rb files/monet-paintings.html` will show Monet's JSON. By default it parses the serpapi provided van-gogh-paintings.html.

To parse and arbitrary html file, use the `Paintings::paintings` method defined in the `paintings.rb` file.

Here under, I leave the original challenge instructions.

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready. 
Do not use more than 4 hours of your time. 

Programming language wise, Ruby is suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages. Pages contains same kind of carrousel. 
