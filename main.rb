require_relative 'lib/carousel_scraper'
require 'json'

file = ARGV[0] || 'files/van-gogh-paintings.html'

html = File.read(file)
scraper = CarouselScraper.new(html)
result = scraper.extract

puts JSON.pretty_generate(result)
