# frozen_string_literal: true

require 'google_search_parser.rb'

RSpec.describe GoogleSearchParser do
  let(:test_file_path) { './files/van-gogh-paintings.html' }
  let(:parser) { described_class.new(test_file_path) }

  describe '#carousel_json' do
    subject(:carousel_array) { parser.carousel_json}

    context 'when carousel not present' do
      let(:test_file_path) { './spec/test_pages/no_carousel.html' }

      it { should eq [] }
    end

    context 'when carousel present' do
      it 'returns a list of item objects' do
        expect(carousel_array.size).to eq(51)
        expect(carousel_array.map(&:keys)).to all(match_array(['name', 'extensions', 'link', 'image']))
      end
    end

  end

  describe '#carousel_card_to_json' do
    let(:card_name) { 'The Starry Night' }
    let(:card) { parser.document.at_css("[aria-label=\"#{card_name}\"]") }

    let(:card_json) { parser.carousel_card_to_json(card) }

    describe 'name field' do
      subject(:name) { card_json['name']}

      it { should eq card_name}

      context 'when name spans multiple lines' do
        let(:card_name) { 'CafÃ© Terrace at Night' }

        it 'returns single line name' do
          expect(name).to eq(card_name)
        end
      end
    end

    describe 'extensions field' do
      subject(:extensions) { card_json['extensions']}

      context 'when extension present' do
        it 'returns the extension value in an array' do
          expect(extensions).to eq(['1889'])
        end
      end

      context 'when extension not present' do
        let(:card_name) { 'Sunflowers'}

        it { should eq []}
      end
    end

    describe 'link field' do
      subject(:link) { card_json['link']}

      it 'includes link to google search result' do
        expect(link).to include('https://www.google.com')
        expect(link).to eq('https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw')
      end
    end

    describe 'image field' do
      subject(:image) { card_json['image']}

      context 'when image present' do
        it 'includes image src' do
          expect(image).not_to be(nil)
        end
      end

      context 'when image not loaded' do
        let(:card_name) { 'The Yellow House' }

        it { should eq nil}
      end
    end
  end
end
