require 'nokogiri'
require 'json'
require_relative 'artwork_parser'

parser = ArtworkParser.new('files/van-gogh-paintings.html')
artworks = parser.parse

artworks.each do |artwork|
  puts artwork["name"]
end
