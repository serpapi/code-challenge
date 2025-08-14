This PR implements a solution to parse artworks from google's search result.

# Solution

## Architecture
I've divided the solution into 2 main classes:

`GoogleSearchPageCrawler`

Responsible for receiving a URL (file path/url), fetch the page HTML and return the correct JSON structure

`GoogleSearchPageCrawler::Parser`
Knows how to parse the page DOM. Its `parse` method returns a `GoogleSearchPageCrawler::Parser::Result` that it's just a data/value object.

If we need to parse more data in the future, one idea is to split the parsing logic into multiple "sub-classes". Example: `GoogleSearchPageCrawler::Parser::ListResult`, `GoogleSearchPageCrawler::Parser::Artworks`, etc. Each class is responsible for parsing a specific section of the page, I don't think that this is strictly necessary but may help to lower the cognitive load when reading the "parser" class if it gets too big and also would facilitate fixing some broken parsing rule.

The `GoogleSearchPageCrawler::Parser::Result` uses dry struct: helping with coersion, default values and also make it easy to document the expected structure
