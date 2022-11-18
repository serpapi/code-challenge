require 'json'
require_relative './artworks_parser.rb'

RSpec.describe ArtworksParser do
  describe '#run' do
    let(:parser) { ArtworksParser.new(path) }

    context 'when extracts Van Gogh artworks' do
      let(:path) { './files/van-gogh-paintings.html' }
      let(:expected_path) { './files/expected-array.json' }
      let(:data) { parser.run }

      it 'returns the expected json result' do
        result = data.map(&:to_h)
        expect(result).to eq JSON.parse(File.read(expected_path), symbolize_names: true)[:artworks]
      end
    end

    context 'when extracts HBO TV Shows' do
      let(:path) { './files/hbo_tv_shows.html' }
      let(:result) { parser.run }

      it 'returns parsed tv shows' do
        expect(result).to all(have_attributes(
          name: be_a(String),
          extensions: be(nil).or(be_a(Array)),
          link: be_a(String).and(start_with('https://www.google.com')),
          image: be(nil).or(be_a(String).and(start_with('data:image')))
        ))
      end

      it 'returns correct data fields' do
        show = result.first
        expect(show.name).to eq 'House of the Dragon'
        expect(show.link).to start_with 'https://www.google.com/search?q=House+of+the+Dragon'
        expect(show.extensions).to match_array ["Since 2022"]
        expect(show.image).to start_with 'data:image/jpeg;base64,/9j/4A'
      end
    end

    context 'when extracts Programming Books' do
      let(:path) { './files/programming-books.html' }
      let(:result) { parser.run }

      it 'returns parsed books' do
        expect(result).to all(have_attributes(
          name: be_a(String),
          extensions: be(nil).or(be_a(Array)),
          link: be_a(String).and(start_with('https://www.google.com')),
          image: be(nil).or(be_a(String).and(start_with('data:image')))
        ))
      end

      it 'returns correct data fields' do
        show = result.first
        expect(show.name).to eq 'Clean Code'
        expect(show.link).to start_with 'https://www.google.com/search?biw=1503&bih=790&q=Clean+Code'
        expect(show.extensions).to match_array ["Robert Cecil Martin, 2008"]
        expect(show.image).to start_with 'data:image/jpeg;base64,/9j/4A'
      end
    end
  end
end
