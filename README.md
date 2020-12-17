# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready. 
Do not use more than 4 hours of your time. 

Programming language wise, Ruby is suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://serpapi.com/knowledge-graph/tests/knowledge-graph/knowledge-graph-claude-monet-paintings-spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

=================================================

#RUN `bin/search_parser files/van-gogh-paintings.html`

To run search_parser run above command to root of application and provide path of html page.

If path is nt provided, it will take deafult path of file (i.e. [files/van-gogh-paintings.html])

`bin/search_parser` It will parse deafault html page.

#Test

To check test with rspec RUN `rspec spec/search_parser_spec.rb` to root of application
