require 'json'
require 'spec_helper'
require_relative '../main'

describe 'HTML to JSON Parser' do
  describe '#parse' do

    let(:parser) { ArtworkParser.new('files/van-gogh-paintings.html') }

    it 'creates an array of artworks' do
      artworks = parser.parse
      expect(artworks).to be_an(Array)
      expect(artworks.first).to be_a(Hash)
      expect(artworks.first).to have_key("name")
    end

    it 'writes to a JSON file' do
      expect(File).to exist("artworks.json")
      json_content = JSON.parse(File.read("./artworks.json"))
      expect(json_content["artworks"]).to be_an(Array)
    end
  end
end
