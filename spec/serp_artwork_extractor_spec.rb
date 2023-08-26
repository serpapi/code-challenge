require 'json'
require './lib/serp_artwork_extractor.rb'
require './lib/mock_serp_loader.rb'

describe SerpArtworkExtractor do
  before :all do
    @actual = SerpArtworkExtractor.new.extract_artworks(
      MockSerpLoader.new.load_serp_document
    )
    @expected = JSON.load(
      File.open('./spec/expected-structure.json'), nil, symbolize_names: true, create_additions: false
    )
  end

  it "creates the correct number of items" do
    expect(@actual.size).to eq(@expected.size)
  end

  it "creates the correct extensions" do
    @actual.each_with_index do |actual_item, index|
      expect(actual_item[:extensions]).to eq(@expected[index][:extensions])
    end
  end

  it "creates the correct links" do
    @actual.each_with_index do |actual_item, index|
      expect(actual_item[:link]).to eq(@expected[index][:link])
    end
  end

  it "creates the correct names" do
    @actual.each_with_index do |actual_item, index|
      expect(actual_item[:name]).to eq(@expected[index][:name])
    end
  end

  it "creates the correct images" do
    @actual.each_with_index do |actual_item, index|
      expect(actual_item[:image]).to eq(@expected[index][:image])
    end
  end
end