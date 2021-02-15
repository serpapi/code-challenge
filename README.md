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

![SERP Scrapper CLI Demo](./files/serpcrawler_demo.gif)

This solution offers a CLI interface to call the scrapping functionality. Here are some command examples:

````shell
  # the main executable, gonna output usage
  ./bin/serpscrapper

  # more help information
  ./bin/serpscrapper --help

  # the list of scrappers (currently available: old/new)
  ./bin/serpscrapper scrappers

  # the main task (old file scraping with images extraction)
  ./bin/serpscrapper scrap --scrapper=old ./files/van-gogh-paintings.html

  # the additional tests (new files scraping with series/film characters)
  ./bin/serpscrapper scrap --scrapper=new ./files/the-big-lebowski-characters.html
  ./bin/serpscrapper scrap --scrapper=new ./files/x-files-characters.html

  # also the 'scrap' command allows to see human-friendly
  # JSON output with --porcelain flag provided
  ./bin/serpscrapper scrap --porcelain --scrapper=new ./files/x-files-characters.html

  # also the 'scrap' command allows to set the top-level JSON key
  # with --key option set
  ./bin/serpscrapper scrap --key=characters --scrapper=new ./files/x-files-characters.html

  # Run the tests
  rspec ./specs
````

## Caveats

Due to time restrictions there some unfinished/untested ideas, potential bugs, etc.

* Using Regexp on huge chunks of text perhaps is not the most effective way of extracting images data, but as a quick
  solution I did exactly that. As a potential solution I thought about using rubyracer/v8 to execute script with a
  replacement of `_setImagesSrc` function to collect its `e, c` arguments containing `img_id => base64` pairs

## Design

* CLI App based on https://devdocs.io allows quickly interact with the scrapper to demo the functionality

## Useful links

* http://jaredwinick.github.io/base64-image-viewer – a quick base64 img tag viewer
* https://github.com/antonmedv/fx | https://stedolan.github.io/jq – CLI JSON viewers and requests
* https://devdocs.io – CLI app "framework" used
* https://github.com/esminc/tapp – my favorite replacement of [letters](https://rubygems.org/gems/letters) gem (I use it with this pretty [printer](https://gist.github.com/smileart/1b9217389904580316780e7c2a0d466a))
