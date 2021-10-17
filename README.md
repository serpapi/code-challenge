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

# Solution

Using Node.Js and Puppeteer (headless chrome) to navigate to a google page. Puppeteer allows interaction, such as accepting the initial Cookie message from Google and navigating right on the carousel to ensure all the images on the carousel are loaded.

## How to use
On the terminal, you have to install all npm packages via:

* Npm install

Then you can launch the defined tests which are run using Jest via:

* Npm test

Which will populate the /out folder with screenshotX.png and dataX.json corresponding to the different tests.

## Assumption

I assumed the expect-array didn't have to be a character to character exact match as links were specified as Google links, but hosting locally would give local links. Again, the opening and ending braces '{' '}' have been left in for the expected JSON file.

### Accuracy over speed

You can speed up the results without scrolling the carousel, if you want the full image list. Again if you keep puppeteer alive rather than create a new instance on each request, that would speed things up. For live google searches, finding the carousel and getting the previous sibling seemed reliable to get the Title name e.g. "Movies", "Artworks", "Books", but not for the given local html (most likely an older format). So it was easier to just depth first search down from the HTML element that contained both the carousel and title bar.

