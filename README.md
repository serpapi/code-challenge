# Code Challenge
Extracts a list of Van Gogh paintings from a local HTML page and exports a JSON file.

Install gems with `bundle install`, run tests with `rspec` or `bundle exec rspec`, and start the program with `ruby main.rb` or `bundle exec ruby main.rb`.

## Notes
This challenge was completed with simplicity in mind, so I went for a single file approach and used `nokogiri` to parse HTML. Image sources are replaced via JS after the page is rendered, making `selenium` a good alternative, but I chose to parse the sources with regular expressions.

I wasn't able to find another page with a carousel. See `files/alt-van-gogh-paintings.html` or `files/red-apple.html` to see how results appear to me. Compare those with the provided Van Gogh file and the page inside an iframe inside [SerpAPIs documentation](https://serpapi.com/google-inline-images).

To fulfill the requirement of testing this in multiple pages, I made an alternative version. Run it with `ruby alt.rb` or `bundle exec ruby alt.rb`. This alternative version will parse 3 pages with similar results: `alt-la-tour-paintings.html`, `alt-picasso-paintings.html`, and `alt-van-gogh-paintings.html`. It's not able to parse `red-apple.html` due to a different layout, for example.