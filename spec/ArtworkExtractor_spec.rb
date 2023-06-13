require_relative '../lib/ArtworkExtractor'
require 'nokogiri'

RSpec.describe ArtworkExtractor do
  describe 'ArtworkExtractor instance' do
    it 'extracts artwork data from HTML element' do
      # Setup
      painting_html = '<div class="painting"><img src="image.jpg" /></div>'
      painting_element = Nokogiri::HTML.fragment(painting_html)

      # Exercise
      extractor = ArtworkExtractor.new(painting_element)
      painting = {
        name: extractor.name,
        extensions: extractor.extensions,
        link: extractor.link,
        image: extractor.image
        
        
      }

      # Verify
      expect(painting).to eq({
        name: nil, # Expected name
        extensions: [] # Expected extensions
        link: nil, # Expected link
        image: "image.jpg",
        
        
      })
    end
  end
end

