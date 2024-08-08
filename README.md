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
[sample json]: files/van-gogh-paintings.json
[html file]:  files/van-gogh-paintings.html
[expected array]: files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages to make sure it works against different layouts. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

The suggested time for this challenge is 4 hours. But, you can take your time and work more on it if you want.

## A Possible solution

In this solution I looked, in the given HTML file, for where the images are located, identifying the CSS of the
`DIV` that groups the paintings, under the Carousel. Then I extracted the paintings data via Nokogiri.

I am using class method, for simplicity, as there is not a need to have several objects. The file is also share via a
class level instance variable, even if it is not really necessary.

### Images

It looks like the paintings' images (base64 inline) are loaded into the carousel's structure lazily via JavaScript, so I added some code to extract them from the scripts via a Regex, so it would match the expected result.

The images that are part of the file (they don't require a network call) are only the few initially visible.

### Running the code

I also created a Ruby file to invoke the program and parse the given [HTML file](files/van-gogh-paintings.html).

After running bundle, from a Terminal window:

```Bash
./demo.rb -h
  Usage:

    To dump the parsed data direcly to the Terminal
      ./demo.rb

    or to a file:
      /.demo.rb result_file.txt

./demo.rb
  {"artworks":[{"name":"The Starry Night","extensions":["1889"],"link":"https://www.google.com/search... }
```

Prefix the call by bundle exec if needed:

```Bash
bundle exec ./demo.rb
  {"artworks":[{"name":"The Starry Night","extensions":["1889"],"link":"https://www.google.com/search... }
```

### Tests

Using rspec, also added the `simplecov gem`, to show the specs' coverage (now at 100%).

After running bundle, run the specs with:

```Bash
rspec
```

For example:

```Bash
rspec
  ....

  Finished in 0.03829 seconds (files took 0.07643 seconds to load)
  4 examples, 0 failures

  Coverage report generated for RSpec to /Users/carloscd/Documents/My Code/Google art scrapping - Coding exercise/servapi_code-challenge/coverage. 43 / 43 LOC (100.0%) covered.
```

Code coverage details, in a web browser:

```Bash
$ open coverage/index.html
```
