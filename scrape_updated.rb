# frozen_string_literal: true

require_relative './app/app'

# This one uses current google layout
raw_filepath = './files/jan-matejko-paintings.html'

raw = File.read(raw_filepath)
parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call

scraper_class = Scrapers::GoogleCarousel20230813
result = scraper_class.new(raw:, parsed:).call

puts JSON.pretty_generate(result)
