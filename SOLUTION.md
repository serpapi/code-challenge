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
