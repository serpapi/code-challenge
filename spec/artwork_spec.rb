require 'json'

describe 'Artworks JSON' do
  attr_reader :json, :expected

  before :all do
    @json = JSON.parse(File.read('lib/files/artworks.json'))
    @expected = JSON.parse(File.read('lib/files/expected-array.json'))
  end

  it 'equals to expected JSON' do
    expect(json).to eq(expected)
  end

  context 'when validating' do
    let(:artworks) { json['artworks'] }

    it 'artworks' do
      expect(artworks).to be_an(Array)
      expect(artworks).to all(be_a(Hash))
      expect(artworks.length).to eq(expected['artworks'].length)
    end

    it 'name, extensions, link, image' do
      artworks.first(10).each do |art|
        expect(art['name']).to be_a(String)
        expect(art['extensions']).to be_an(Array).or be(nil)
        expect(art['link']).to be_a(String).and start_with('https://www.google.com')
        expect(art['image']).to be_a(String).or be(nil)
        expect(art['image']).to start_with('data:image/jpeg') unless art['image'].nil?
      end
    end

    it 'Café Terrace at Night' do
      art = artworks[4]
      expect(art['name']).to eq('Café Terrace at Night')
      expect(art['extensions']).to eq(['1888'])
      expect(art['link']).to start_with('https://www.google.com')
      expect(art['image']).to start_with('data:image/jpeg')
    end
  end
end
