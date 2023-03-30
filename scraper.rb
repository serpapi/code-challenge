require 'nokogiri'
require 'json'
require_relative 'lib/artwork_parser'

html_contents = File.read('files/van-gogh-paintings.html')
doc = Nokogiri::HTML(html_contents)

artworks = doc.xpath('(//g-scrolling-carousel)[1]//div/div/div')
result = parse_artworks(artworks)
  
File.open('result.json', 'w') do |f|
    f.write(JSON.pretty_generate(result))
end