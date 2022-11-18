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
  end
end
