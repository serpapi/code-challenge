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

# Solution

I used Python as programming language and [Selenium](https://www.selenium.dev/) for browser automation.

Code is located in `image_extractor/__init__.py` file, tests are in `test/test_image_extractor.py`. HTML files used for testing are located in `test/data` directory.

I decided to package it using Docker because it uses Selenium which is a bit tricky to install. Please use the following commands to build and run container:

`docker build --tag imageparser:0.0.1 .` - build an image

`docker run --name imageparser imageparser:0.0.1` - run tests

`docker run --name imageparser -v ~/projects/code-challenge/files:/files imageparser:0.0.1 /app/run.py /files/van-gogh-paintings.html` - run script with specific Google results html file. Replace ~/projects/code-challenge/files with file on your machine where HTML files arestored, and /files/van-gogh-paintings.html with filename you want to use.
