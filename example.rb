require_relative 'lib/google_artworks_parser'
require 'json'

parser = GoogleArtworksParser.new('./files/van-gogh-paintings.html')
artworks = parser.artworks

puts JSON.pretty_generate(artworks)