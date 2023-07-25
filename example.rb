require_relative 'lib/google_artworks_parser'
require 'json'

parser = GoogleArtworksParser.new('./files/van-gogh-paintings.html')
artworks = parser.get_results
File.write('./outputs/van-gogh-paintings.json', JSON.pretty_generate(artworks))

parser.path = './files/van-gogh-paintings-new.html'
artworks = parser.get_results
File.write('./outputs/van-gogh-paintings-new.json', JSON.pretty_generate(artworks))

parser.path = './files/picasso-paintings.html'
artworks = parser.get_results
File.write('./outputs/picasso-paintings.json', JSON.pretty_generate(artworks))
