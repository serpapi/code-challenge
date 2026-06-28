require 'rspec'
require 'json'
require_relative '../modules/naive_parser'

RSpec.describe NaiveParser do
  let(:parser) { NaiveParser.new }
  let(:html) { File.read('spec/fixtures/2024/van-gogh-paintings.html') }
  let(:expected) { JSON.parse(File.read('spec/fixtures/2024/expected-array.json')) }

  describe '#parse' do
    it "returns a json object with a key 'artworks' pointing at an array" do
      paintings = JSON.parse(parser.parse(html))
      expect(paintings).to have_key('artworks')
      expect(paintings['artworks']).to be_an(Array)
    end

    it 'returns an object containing an array of artworks' do
      paintings = JSON.parse(parser.parse(html))
      expect(paintings['artworks']).to be_an(Array)
      expect(paintings['artworks']).not_to be_empty
    end

    it 'returns paintings with name, extensions, link, and image' do
      paintings = JSON.parse(parser.parse(html))
      painting = paintings['artworks'].first

      expect(painting).to have_key('name')
      expect(painting).to have_key('extensions')
      expect(painting).to have_key('link')
      expect(painting).to have_key('image')
    end

    it 'matches the expected array' do
      paintings = JSON.parse(parser.parse(html))
      expect(paintings).to eq(expected)
    end
  end
end
