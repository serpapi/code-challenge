require 'google_carousel'
require 'json'

describe GoogleCarousel do
  subject { GoogleCarousel.new(raw_html) }
  let(:raw_html) { File.read('files/van-gogh-paintings.html') }

  describe '#items' do
    let(:fixture) { JSON.load(File.read('files/van-gogh-paintings.json')) }

    it 'parses the carousel items correctly' do
      expect(subject.items).to eq(fixture.dig('knowledge_graph', 'artworks'))
    end
  end
end
