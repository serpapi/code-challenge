require 'nokogiri'
require 'json'
require_relative '../lib/extract'

RSpec.describe "extract_data_from_html" do
  it "extracts the painting data from the given HTML" do
    data = extract_data_from_html("./files/van-gogh-paintings.html")

    expected_data = JSON.parse(File.read("./files/expected-array.json"), symbolize_names: true)
        
    data_without_images = data[:artworks].map { |painting| painting.reject { |k| k == :image } }
    expected_without_images = expected_data[:artworks].map { |painting| painting.reject { |k| k == :image } }
    
    expect(data_without_images).to eq(expected_without_images)
  end
end
