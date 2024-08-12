# frozen_string_literal: true

require_relative '../lib/google_carousel_extractor/extractor'

RSpec.describe GoogleCarouselExtractor::Extractor do
  let(:html_file) { 'files/van-gogh-paintings.html' }
  let(:extractor) { described_class.extract(html_file) }

  describe '#extract' do
    it 'returns an array of artwork objects' do
      items = extractor
      expect(items).to be_an(Array)
      expect(items.size).to eq(51)
      expect(items).to all(be_a(Hash))
    end

    context 'when no carousel element present within html' do
      let(:html_file) { 'spec/fixtures/no-carousel.html' }

      it 'returns an empty array' do
        expect(extractor).to eq([])
      end
    end
  end
end
