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

## How To

After cloning the repo, run `bundle install` to ensure all required gems are installed.

Run `bundle exec ruby scrape.rb files/van-gogh-paintings.html` to execute the scraper. You must include a valid filepath to an HTML file for the script to run. Follow the prompts if you encounter any errors.

In addition to the provided Van Gogh page, I've added two additional pages from Google search results containing a new layout. The scraper will automatically detect the page's format and scrape the contents accordingly. See `files/botticelli-paintings.html` and `files/rublev-paintings.html` for the newer Google SERP format.

The script will output a JSON file with the results. This file will be located in the `result_files` directory. The directory will automatically be created if it doesn't already exist.

## Tests

Run `bundle exec rspec` to run the tests.
