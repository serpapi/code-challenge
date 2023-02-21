require 'json'

describe 'Artworks JSON' do
  attr_reader :json, :expected

  context 'when validating van gogh' do
    let(:json) { JSON.parse(File.read('lib/files/van-gogh.json')) }
    let(:artworks) { json['artworks'] }

    it 'artworks' do
      expect(artworks).to be_an(Array)
      expect(artworks).to all(be_a(Hash))
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
      art = artworks[5]
      expect(art['name']).to eq('Café Terrace at Night')
      expect(art['extensions']).to eq(['1888'])
      expect(art['link']).to start_with('https://www.google.com')
      expect(art['image']).to start_with('data:image/jpeg')
    end
  end

  context 'when validating picasso' do
    let(:json) { JSON.parse(File.read('lib/files/picasso.json')) }
    let(:artworks) { json['artworks'] }

    it 'Guernica' do
      art = artworks.first
      expect(art['name']).to eq('Guernica')
      expect(art['extensions']).to eq(['1937'])
      expect(art['link']).to start_with('https://www.google.com')
      expect(art['image']).to start_with('data:image/jpeg')
    end
  end
end
