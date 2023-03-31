require 'nokogiri'
require 'json'
require_relative 'lib/google_carousel_scraper'

scraper = GoogleCarouselScraper.new("./files/van-gogh-paintings.html") 
result = scraper.scrape_artworks

File.open('artworks.json', 'w') do |f|
    f.write(JSON.pretty_generate(result))
end