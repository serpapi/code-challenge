require 'rspec'
require 'json'
require 'parser'

RSpec.describe Parser, '#parse' do
  context 'Van Gogh paintings Google search results page' do
    subject { described_class.new('./files/van-gogh-paintings.html') }

    it 'should be a hash of artworks' do
      expect(subject.parse).to be_a(Hash).and include('artworks')
    end

    it 'should extract painting names' do
      expect(subject.parse['artworks']).to include(hash_including('name' => 'The Starry Night'))
    end

    it 'should extract years' do
      expect(subject.parse['artworks']).to include(hash_including('extensions' => ['1889']))
    end

    it 'should extract Google links' do
      expect(subject.parse['artworks']).to(
        include(hash_including('link' => starting_with('https://www.google.com')))
      )
    end

    it 'should extract thumbnails' do
      expect(subject.parse['artworks']).to include(hash_including('image' => including('3GQNAA5ODtW')))
    end

    it 'should match expected array' do
      File.write('results', JSON.pretty_generate(subject.parse))
      expect(subject.parse).to eq JSON.parse(File.read('./files/expected-array.json'))
    end
  end
end
