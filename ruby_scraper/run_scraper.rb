require 'json'
require_relative 'lib/google_carousel_scraper'


g = GoogleCarouselScraper.new("../files/van-gogh-paintings.html")
results = g.extract()

File.open("output/artworks_array.json", "w") do |f|
  f.write(JSON.pretty_generate(results))
end