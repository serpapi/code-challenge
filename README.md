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

# CHALLENGE MET

## Implementation

Fast and lightweight implementation; with Nokogiri, Thor and ActiveSupport as dependencies; that 3rd is only used for message formatting. 

+ No HTTP calls -> the documents to parse are already captured in `files/`
+ No JS execution required: thumbnails image source extraction is done by a REGEX. Otherwise we would have required something like selenium, capybara-webkit...which is heavy and cumbersome (thinking of requiring you to install xvfb, qt, PhantomJS)

## RUNNING

I use [Thor](https://rubygems.org/gems/thor) gem to provide the command line interface

`cd` into the directory and run `thor serpapi:search_google_image "Van Gogh paintings"`

As instructed I added 2 other artwork pages for Pablo Picasso and Claude Monet. You can run them the same way too:

`thor serpapi:search_google_image "Pablo Picasso paintings"`

OR

`thor serpapi:search_google_image "Claude Monet paintings"`

**Notes**

+ I matched the search keyword with the names of the files used for the data extraction (see within `files/`), so anything different will not hit the right page and will return an empty result
+ As of now July 2020, Google slightly updated the HTML structure of the artworks carousel. With that fact in mind, I had to adapt the code with some switches to support Van Gogh, which I guess was captured in 2019, and Picasso/Monet that I captured today 15th July 2020.

## TESTING

Rake + Minitest are used for the unit test of `GoogleImageSearch` class. 

I covered the case of Van Gogh only using the provided `files/expected-array.json`

To run the tests do `rake test` or just `rake`

**THE TEST COVERAGE FAILS!!**
*As I remarked and wrote as a comment in the test scenario, the provided `files/expected-array.json` is wrong beginning at the 9th image: you expect the image to be NIL while the provided document shows an image for "The Yellow House (1888)"*
