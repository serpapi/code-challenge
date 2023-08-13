# frozen_string_literal: true

require_relative './app/app'

# This one is the solution to the code-challenge
# but the source file is outdated hence another scraper
raw_filepath = './files/van-gogh-paintings.html'

raw = File.read(raw_filepath)
parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call

scraper_class = Scrapers::GoogleCarousel20190319
result = scraper_class.new(raw:, parsed:).call

puts JSON.pretty_generate(result)
