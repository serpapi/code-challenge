# frozen_string_literal: true

require_relative '../lib/google_carousel_extractor/carousel_parser'
require_relative '../lib/google_carousel_extractor/carousel_item_builder'

RSpec.describe GoogleCarouselExtractor::CarouselItemBuilder do
  let(:html_file) { 'files/van-gogh-paintings.html' }
  let(:parser) { GoogleCarouselExtractor::CarouselParser.new(html_file) }
  let(:a_tag) { parser.items.first }
  let(:builder) { described_class.new(a_tag) }

  describe '#build' do
    let(:item) { builder.build }

    it 'has a name' do
      expect(item[:name]).to eq('The Starry Night')
    end

    it 'has a link' do
      expect(item[:link]).to eq('https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw')
    end

    it 'has an extensions' do
      expect(item[:extensions]).to eq(['1889'])
    end

    it 'has an image' do
      expect(item[:image]).to eq('data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')
    end

    context 'when no images present in item' do
      let(:html_file) { 'spec/fixtures/paintings-without-images.html' }

      it 'has other fields' do
        expect(item[:name]).to eq('The Starry Night')
        expect(item[:link]).not_to be_empty
        expect(item[:extensions]).to eq(['1889'])
      end

      it 'does not have an image' do
        expect(item[:image]).to be_nil
      end
    end
  end
end
