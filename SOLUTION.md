This PR implements a solution to parse artworks from google's search result.

# Solution

## Architecture
I've divided the solution into 2 main classes:

`GoogleSearchPageCrawler`

Responsible for receiving a URL (file path/url), fetch the page HTML and return the correct JSON structure

`GoogleSearchPageCrawler::Parser`
Knows how to parse the page DOM.

Its `parse` method returns a `GoogleSearchPageCrawler::Parser::Result`: a pure ruby data/value object. The `GoogleSearchPageCrawler::Parser::Result` uses dry struct: helping with coersion, default values and also make it easy to document the expected structure

*No need to split into more classes*
If we need to parse more data in the future, one idea is to split the parsing logic into multiple "sub-classes" instead of methods.

Example: `GoogleSearchPageCrawler::Parser::ListResult`, `GoogleSearchPageCrawler::Parser::Artworks`, etc.

Each class parses a specific part of the result. It's not strictly necessary but may help to lower the cognitive load when reading the "parser" class if it gets too big, keep the code organized and facilitate knowing where to look for fixing a specific broken parsing rules.

## GoogleSearchPageCrawler::Parser parsing logic

### Image
The readme reinforces that we have to keep the image attribute for both cases:

- the base64 encoded image
- the image link (those that require a click on the "show more" button)

When I've executed a test against the `expected-array.json` file, I've noticed that the `<img>` tag for each artwork have a src with a gif.

- those with the base64 thumbnail have an id attribute.
```html
<img class="taFZJe" alt="The Potato Eaters" id="_L_FkZ4qlAtyDwbkP49Pj0QU_79" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-deferred="1">
```

- those with the image link have a `data-src` attribute.
```html
<img class="taFZJe" alt="Self-Portrait with Bandaged Ear" data-src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8juuefle5MyKZKBLRgPjsGSJon7vkt91SM7WTRuZOOyAyUI1v" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="/>
```

#### Base64 encoded image
The same ID reappears inside a script tag with their base64 encoded image.

```html
<script nonce="xmO6un4J9murPFDygFfaMA">(function(){var s='data:image/webp;base64,UklGRjQMAABXRUJQVlA4ICgMAAAQRACdASrhAJsAPxGAt1QsKCU1KDV7MqAiCWcHDtAkSjkn/r/Xf+ydgBeraVdn/9Px1UGv5GYPyffrugwzIfw/Rc/+vnb/kP/hwO2JbSYKG1VQIN78tct7QVKKyA/XDj2TQ174tLSeF8ejv+SZJ2zx....';var ii=['_L_FkZ4qlAtyDwbkP49Pj0QU_79'];var r='';_setImagesSrc(ii,s,r);})();</script>
```

So, we have to find the script tag with the same ID and extract the base64 encoded image from there.

#### Image link

We just have to extract the `data-src` attribute from the `<img>` tag.

# Usage

## Running tests
`bundle exec rspec` to run feature specs (uses fixtures) or more unit tests from the `lib` folder.

## Scraping a search page

Execute
`bundle exec ruby scrape_files.rb FILENAME.HTML` to use the `GoogleSearchPageCrawler` to crawl the page and parse the artworks.