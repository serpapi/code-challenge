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

## Solution

I built a small carousel scraper using `Nokogiri` and regex. It finds the best Knowledge Graph carousel container by looking for `data-attrid` sections and links that include `stick=`, then extracts fields for each item. I prioritised semantic HTML (`role`, `aria-label`, `alt`, `title`) over class names. It also skips "show more" items and only includes images already present in the HTML (`data:image`, `encrypted-tbn`, or `knowledgecard` icons).

The output is a hash where the key matches the search results selected tab (e.g., `artworks`, `cast`, `albums`). If no tab is selected, it defaults to `results`.

### Structure

- `lib/carousel_scraper.rb`: Orchestrates the extraction and chooses the correct carousel scope.
- `lib/carousel_item_extractor.rb`: Extracts name, extensions, link, and image from a single item link.

I tested against 3 other result pages to find common patterns:

- "David Bowie albums" search: files/david-bowie-albums.html
- "George Orwell books" search: files/george-orwell-books.html
- "Lord of the Rings cast" search: files/lord-of-the-rings-cast.html

### How to run

Install dependencies:

```
bundle install
```

Run with the default Van Gogh paintings HTML:

```
ruby main.rb
```

Run with a specific HTML file:

```
ruby main.rb files/david-bowie-albums.html
ruby main.rb files/george-orwell-books.html
ruby main.rb files/lord-of-the-rings-cast.html
```

Run the tests:

```
bundle exec rspec
```
