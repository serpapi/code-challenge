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

----

## Thomas Hurst Participation Notes

The end result of several hours of effort is:

* `lib/google_carousel_scraper.rb` containing a small scraper returning carousels as an `Enumerable`
* `spec/google_carousel_scraper_spec.rb` which tests the scraper against several Google result pages
* `bin/scrape_carousel` which returns the scraping results from a file or STDIN as prettified JSON

Scraped data from the provided `van-gogh-paintings.html` matches the target data
provided in `van-gogh-paintings.json` exactly, bar corrupt base64 padding which
is not replicated by my scraper.

### Usage

Tested on Ruby 2.7 and 3.2.

```
$ bundle install
$ bundle exec rspec
$ bundle exec bin/scrape_carousel files/van-gogh-paintings.html
$ bundle exec bin/scrape_carousel files/modern-art-paintings-2023-04-10.html
$ bundle exec bin/scrape_carousel files/steven-spielberg-films-2023-04-10.html
```
