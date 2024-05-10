# Extract Van Gogh Paintings Code Challenge

## Notes  

1. Initialized Ruby skeleton for the project with boilerplate RSpec and empty parsing class. Used `bundle` for gem install. 
2. Wrote RSpec tests. Passing on minimized example of given expected array.
3. Formatted the target HTML and found the carousel divs and desired properties. Wrote the parser with regex extraction rules based off of the class names and HTML element structure of the carousel. Updated the tests to reflect the "extensions" object sometimes not existing and to reflect multiple base64 image types. The result is passing the tests.
4. Compared returned and expected JSON to find that the base64 image in the HTML directly is a stub, and the expected base64 image is in a script which is injected into the div. Found that the `id` for the image div uniquely identifies it, and ties it to the expected base64 image. Updated the parser to pull in the base64 images from the script, and insert them into their respective hash. 
5. As a last step I decided to compare the actual JSON output of the parser and the expected JSON. Added a get_json method which uses the `json` module to convert the Ruby hash representation to JSON. Imported the expected JSON and the parser output JSON and compared them with a test, ensuring that every property of every object matches exactly. I found that there are some small idiosyncrasies between the two which failed the `link` and `image` tests:
  a. Links in the provided HTML are sanitized, so ampersands are represented as `&amp;` instead of `&`. Updated the parser to remove `amp;`, which made the exact matching tests pass
  b. Base64 encoded images in the provided HTML have a few backslashes at the very end, while in the expected JSON they do not. It's unclear to me why this is, but backslashes are not included characters in the base64 encoding spec so I can safely remove them without changing the image data. After removing the backslashes the exact matching tests pass

---

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
