require_relative 'scraper.rb'
require 'json'

files = ['van-gogh', 'michelangelo', 'da-vinci']

files.each do |file_name|
  scraper = PaintingScraper.new('files/' + file_name + '-paintings.html')
  paintings = scraper.parse_html
  json = JSON.pretty_generate(paintings)
  File.open('output/' + file_name + '.json', 'w') do |file|
    file.write(json)
  end
end
