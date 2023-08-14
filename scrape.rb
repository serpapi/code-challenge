# frozen_string_literal: true

require_relative './app/app'

def scrape_and_print(raw_filepath, scraper_class)
  raw = File.read(raw_filepath)
  parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call
  result = scraper_class.new(raw:, parsed:).call

  puts JSON.pretty_generate(result)
end

# This one is the solution to the code-challenge
# but the source file is outdated hence another scraper
challenge_scraper_class = Scrapers::GoogleCarousel20190319
scrape_and_print('./files/van-gogh-paintings.html', challenge_scraper_class)

# This one uses current google layout
updated_scraper_class = Scrapers::GoogleCarousel20230813
scrape_and_print('./files/jan-matejko-paintings.html', updated_scraper_class)
scrape_and_print('./files/claude-monet-paintings.html', updated_scraper_class)
