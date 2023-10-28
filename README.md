# Google carousel images' scraper

## Usage

1. `bundle install`
1. `chmod +x ./bin/scrape.rb`
1. `ruby bin/quick-test.rb spec/fixtures/movies.html`

Or run the test cases with `rspec`.

## Notes

The original test case has an old (2019) Google schema. Rather than building two parsers (the current schema is significantly different), I fetched a couple of HTMLs from previous candidates' submissions.
