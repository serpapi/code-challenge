# Extract Van Gogh Paintings Code Challenge

The goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready.
Do not use more than 4 hours of your time.

Programming language wise, Ruby is suggested, but feel free to use whatever you prefer.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://serpapi.com/knowledge-graph/tests/knowledge-graph/knowledge-graph-claude-monet-paintings-spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Also add the painting thumbnails to your array (present in the result page file, not the ones where extra requests are needed).

Test against 2 other similar result pages. (Pages that contain the same kind of carousel. Don't necessarily have to be paintings.)

## Usage

![SERP Crawler CLI Demo](./files/serpcrawler_demo.gif)

This solution offers a CLI interface to call the crawling functionality. Here are some command examples:

````shell
  # the main executable, gonna output usage
  ./bin/serpcrawler

  # more help information
  ./bin/serpcrawler --help

  # the list of stencils (see Design for more details)
  ./bin/serpcrawler stencils

  # the main task (old file scraping with images extraction)
  ./bin/serpcrawler crawl --stencil=google_art_carousel ./files/van-gogh-paintings.html

  # the additional tests (new files scraping with book/film characters, see Caveats for some downsides)
  ./bin/serpcrawler crawl --stencil=google_characters_carousel ./files/the-big-lebowski-characters.html
  ./bin/serpcrawler crawl --stencil=google_characters_carousel ./files/harry-potter-characters.html

  # also the 'crawl' command allows to see human-friendly
  # JSON output with --porcelain flag provided
  ./bin/serpcrawler crawl --porcelain --stencil=google_characters_carousel ./files/harry-potter-characters.html

  # Run the tests 
  rspec ./specs
````

## Caveats

Due to time restrictions there some unfinished/untested ideas, potential bugs, etc.

* With the **modern Google SERP HTML** some images are contained within "src" in base64 without JS, although farther
  carousel items require deeper examination cause they reference files folder (for locally saved page) and some
  contain 1x1 gif pixel images, which I didn't attempt to resolve through ID
* Using Regexp on huge chunks of text perhaps is not the most effective way of extracting images data, but as a quick
  solution I did exactly that. As a potential solution I thought about using rubyracer/v8 to execute script with a
  replacement of `_setImagesSrc` function to collect its `e, c` arguments containing `img_id => base64` pairs
* My HTML scrapper is a pretty old piece of code I reused time and again in some of my projects, so the current version
  is not and should not be considered as something I'm proud of, but I decided to use it here cause it suits the task at
  hand and helped me save time. Some features were retrofitted to the old code as a seat-of-the-pants solution without any tests.
* Convention over configuration and that sort of "magic" certainly is not my cup of tea, but for the purposes of this task I went with
  that in naming stencils and constants inside

## Design

* CLI App based on https://devdocs.io allows quickly interact with the crawler/scrapper to demo the functionality
* The concept of Stencils allows us to have pluggable/replaceable "cassettes" to swap the shape/cleanup of the
  scraped data in one place, the idea actually worked for me really well in the past (fun fact: it comes from
  this old Soviet series titles https://youtu.be/rbW2SJ0Kf8I?t=4153)
* Using of my own Ruby gem (https://github.com/smileart/hash_remapper) to handle the final data building step might be
  an overkill in this particular case, but I find it convenient to have it installed and ready in my toolbox, JIC

## Useful links

* http://jaredwinick.github.io/base64-image-viewer – a quick base64 img tag viewer
* https://github.com/antonmedv/fx | https://stedolan.github.io/jq – CLI JSON viewers and requests
* https://devdocs.io – CLI app "framework" used
* https://github.com/esminc/tapp – my favorite replacement of [letters](https://rubygems.org/gems/letters) gem (I use it with this pretty [printer](https://gist.github.com/smileart/1b9217389904580316780e7c2a0d466a))
