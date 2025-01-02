require 'json'
require_relative '../parse_artworks_for_paintings'

RSpec.describe 'parse_artworks_for_van_gogh_paintings' do
  let(:expected_result) do
    file_path = 'files/expected-array.json'
    JSON.parse(File.read(file_path))["artworks"]
  end

  let(:generated_result) do
    file_path = 'files/van-gogh-paintings.html'
    parse_artworks_for_paintings(file_path)
  end

  context 'when comparing all artworks' do
    it 'matches the all the artworks' do
      expect(generated_result).to eq(expected_result)
    end

    it 'matches the total number of artworks' do
      expect(generated_result.size).to eq(expected_result.size)
    end
  end

  context 'when comparing individual artworks' do
    it 'matches the name for each artwork' do
      generated_result.each_with_index do |artwork, index|
        expect(artwork["name"]).to eq(expected_result[index]["name"])
      end
    end

    it 'matches the extensions for each artwork' do
      generated_result.each_with_index do |artwork, index|
        expect(artwork["extensions"]).to eq(expected_result[index]["extensions"])
      end
    end

    it 'matches the link for each artwork' do
      generated_result.each_with_index do |artwork, index|
        expect(artwork["link"]).to eq(expected_result[index]["link"])
      end
    end

    it 'matches the image for each artwork' do
      generated_result.each_with_index do |artwork, index|
        expect(artwork["image"]).to eq(expected_result[index]["image"])
      end
    end
  end
end

RSpec.describe 'parse_artworks_for_claude_monet_paintings' do
  let(:generated_result) do
    file_path = 'files/claude-monet-paintings.html'
    parse_artworks_for_paintings(file_path)
  end

  it 'returns valid artworks with correct data' do
    generated_result.each do |artwork|
      expect(artwork.keys).to include("name", "link", "image")
      expect(artwork.keys).to include("extensions") unless artwork["extensions"].nil?

      expect(artwork["name"]).to be_a(String)
      expect(artwork["name"]).not_to be_empty

      expect(artwork["link"]).to be_a(String)
      expect(artwork["link"]).to match(%r{^https?://})

      expect(artwork["image"]).to be_a(String)
      expect(artwork["image"]).not_to be_empty

      if artwork["extensions"]
        expect(artwork["extensions"]).to be_an(Array)
        expect(artwork["extensions"]).to all(be_a(String))
      end
    end
  end
end
