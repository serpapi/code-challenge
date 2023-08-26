#!/usr/bin/ruby

require 'json'
require './lib/mock_serp_loader.rb'
require './lib/serp_artwork_extractor.rb'

puts JSON.pretty_generate({
  'artworks': SerpArtworkExtractor.new.extract_artworks(
    MockSerpLoader.new.load_serp_document
  )
})
