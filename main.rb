require_relative 'scraper.rb'
require 'json'

scraper = PaintingScraper.new('files/van-gogh-paintings.html')
paintings = scraper.parse_html
json = JSON.pretty_generate(paintings)

File.open('van-gogh-paintings.json', 'w') do |file|
  file.write(json)
end