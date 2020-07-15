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

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

***

## CHALLENGE MET

Fast and lightweight implementation:

+ No HTTP calls -> the documents to parse are already provided in `files/`
+ No JS execution required: thumbnails image source extraction is done by a REGEX, otherwise would have required something like selenium, capybara-webkit...

## RUNNING

I use (Thor)[https://rubygems.org/gems/thor] gem to provide the command line interface

`cd` into the directory and run `thor serpapi:search_google_image "Van Gogh paintings"`

As instructed I added pages for Pablo Picasso and Claude Monet so you can run them the same way too:

`thor serpapi:search_google_image "Pablo Picasso paintings"`

OR

`thor serpapi:search_google_image "Claude Monet paintings"`

**Notes**

+ I matched the search keyword with the filenames, so anything different will not hit the right page and will return an empty result
+ As of now July 2020, Google updated the structure of the result page, so I had to adapt the code with some switches with that fact for the 2 painters I choose.

## TESTING

I use Rake + Minitest to unit test the `GoogleImageSearch` class. 

I covered the case of Van Gogh only using the provided `files/expected-array.json`

To run the tests do `rake test` or just `rake`

As I remarked and wrote as a comment in the test scenario, the provided `files/expected-array.json` is wrong beginning at the 9th image: you expect the image to be NIL while the provided document shows an image for "The Yellow House (1888)"
