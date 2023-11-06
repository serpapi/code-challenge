require 'json'
require './lib/google_artworks_extractor'

RSpec.describe GoogleArtworksExtractor do
  let(:input) { File.read('files/van-gogh-paintings.html') }
  let(:expected_output) { JSON.parse(File.read('files/expected-array.json'), symbolize_names: true) }

  subject { described_class.new(input) }

  describe '#run' do
    it 'returns an array of artworks' do
      expect(subject.run).to match(expected_output)
    end
  end
end
