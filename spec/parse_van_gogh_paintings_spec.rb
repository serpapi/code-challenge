require_relative '../parse_van_gogh_paintings'
require 'json'

# TODO: Test to match my file result with provided expected `.json` file result - overall match, and then also by each key as that would help with debugging?

RSpec.describe 'parse_van_gogh_paintings' do
  let(:expected_result) do
    file_path = 'files/expected-array.json'
    JSON.parse(File.read(file_path))["artworks"]
  end

  let(:generated_result) do
    file_path = 'files/van-gogh-paintings.html'
    parse_van_gogh_paintings(file_path)
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
