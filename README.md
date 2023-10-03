# Overview
This script is a code challenge for SerpApi and leverages Nokogiri to parse and extract specific elements, specifically carousels, from Google search results HTML. The results are then transformed into a more readable JSON format.

# Features
* Parses Google search results HTML.
* Targets and extracts carousels based on the g-scrolling-carousel element.
* Transforms extracted data into prettified JSON for easy reading.

# Setup
## Dependencies

Ensure you have Ruby installed on your machine. This script was developed and tested on Ruby version 3.2.2

## Installation

1. Clone the repository 
```
git clone git@github.com:Hopperman/code-challenge.git
cd code-challenge
git checkout hanno-challenge
```

2. Bundle
```
bundle install
```

# Executing the script

`ruby scrape.rb`

# Limitations

* The script assumes the presence of the g-scrolling-carousel element in the HTML. If Google changes their markup, this script may require updates.

# Troubleshooting

* InvalidCarouselLocationError: Ensure that the HTML file being parsed contains the g-scrolling-carousel element

# Testing
Tests are written in RSpec.

To run the test suite:
`bundle exec rspec`

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
