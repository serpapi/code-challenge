require 'rspec_helper'

describe GoogleCarousel do
  let(:raw_html) { File.read('files/van-gogh-paintings.html') }

  before do
    @actual_result = described_class.parse(raw_html)
    @expected_result = JSON.load(File.read('files/expected-array.json'))
  end

  describe '#parse' do
    it 'parses the artworks items correctly' do
      expect(@actual_result).not_to be_empty
      expect(@actual_result["artworks"].size).to eq(@expected_result["artworks"].size)
    end

    it 'parses the artworks item - name correctly' do
      expect(@actual_result['artworks'][0]['name']).not_to be_empty
    end

    it 'parses the artworks item - link correctly' do
      expect(@actual_result['artworks'][0]['link']).not_to be_empty
    end

    it 'parses the artworks item - extensions correctly' do
      expect(@actual_result['artworks'][0]['extensions']).not_to be_empty
    end

    it 'parses the artworks item - image correctly' do
      expect(@actual_result['artworks'][0]['image']).not_to be_empty
    end

    it 'parses the artworks item - values correctly' do
      actual_item_1 = @actual_result['artworks'][0]
      expected_item_1 = @expected_result['artworks'][0]

      expect(actual_item_1["name"]).to eq(expected_item_1["name"])
      expect(actual_item_1["link"]).to eq(expected_item_1["link"])
      expect(actual_item_1["extensions"]).to eq(expected_item_1["extensions"])
      expect(actual_item_1["image"]).to eq(expected_item_1["image"])
    end
  end
end
