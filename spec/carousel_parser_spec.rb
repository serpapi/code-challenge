# frozen_string_literal: true

require_relative '../lib/google_carousel_extractor/carousel_parser'

RSpec.describe GoogleCarouselExtractor::CarouselParser do
  let(:html_file) { 'files/van-gogh-paintings.html' }
  let(:parser) { described_class.new(html_file) }

  describe '#items' do
    it 'returns an array of a_tags within the carousel' do
      items = parser.items
      expect(items).to be_an(Nokogiri::XML::NodeSet)
      expect(items).to all(be_a(Nokogiri::XML::Element))
      expect(items.first.name).to eq('a')
    end
  end
end
