require_relative 'spec_helper'

describe "Scraper" do
  describe "Format Version 1" do
    it "should match sample JSON file" do
      expected_result = JSON.load(File.read("spec/support/van-gogh-paintings.json"))
      scraped_artworks = GoogleArtworkScraper.new("files/van-gogh-paintings.html").scrape
      
      expect(scraped_artworks).to match(expected_result)
    end
  end

  describe "Format Version 2" do
    it "should match sample JSON file" do
      expected_result = JSON.load(File.read("spec/support/botticelli-paintings.json"))
      scraped_artworks = GoogleArtworkScraper.new("files/botticelli-paintings.html").scrape
      
      expect(scraped_artworks).to match(expected_result)
    end
  end
end