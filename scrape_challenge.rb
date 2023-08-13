require_relative './app/app.rb'

# This one is the solution to the code-challenge
# but it's outdates hence the other scraper
raw_filepath = './files/van-gogh-paintings.html'
json_filepath = './files/expected-array.json'

raw = File.read(raw_filepath)
parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call

scraper_class = Scrapers::GoogleCarousel20190319
result = scraper_class.new(raw:, parsed:).call

puts JSON.pretty_generate(result)