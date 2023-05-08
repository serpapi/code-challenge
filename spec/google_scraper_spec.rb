# frozen_string_literal: true

require "json"
require "google_scraper"

describe "Google scraper - Van Gogh" do
  before do
    @response = GoogleScraper.new("files/van-gogh-paintings.html").scrape
  end

  it "matches provided array" do
    expected_array = JSON.parse(File.read("files/expected-array.json"))

    expect(@response["artworks"].length).to eq(expected_array["artworks"].length)

    @response["artworks"].each_with_index do |artwork, index|
      expect(artwork).to eq(expected_array["artworks"][index])
    end
  end
end

describe "Google scraper - Modern painters" do
  before do
    @response = GoogleScraper.new("files/modern-painters.html").scrape
  end

  it "matches provided array" do
    expect(@response["artworks"].length).to eq(51)
    expected_array = JSON.parse(File.read("files/expected-array-modern-painters.json"))

    first_item = @response["artworks"].first
    first_expected_item = expected_array["artworks"].first
    expect(first_item["name"]).to eq(first_expected_item["name"])
    expect(first_item["link"]).to eq(first_expected_item["link"])
    expect(first_item["image"]).to eq(first_expected_item["image"])

    last_item = @response["artworks"].last
    last_expected_item = expected_array["artworks"].last
    expect(last_item["name"]).to eq(last_expected_item["name"])
    expect(last_item["link"]).to eq(last_expected_item["link"])
    expect(last_item["image"]).to eq(last_expected_item["image"])
  end
end
