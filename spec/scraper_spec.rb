require_relative 'spec_helper'

describe "Scraper" do
  describe "Format Version 1" do
    it "should match sample V1 JSON file" do
      expected_result = JSON.load(File.read("spec/support/van-gogh-paintings.json"))
      scraped_artworks = GoogleArtworkScraper.new("spec/support/van-gogh-paintings.html").scrape
      
      expect(scraped_artworks).to match(expected_result)
    end
  end

  describe "Format Version 2" do
    it "should match sample V2 JSON file" do
      expected_result = JSON.load(File.read("spec/support/botticelli-paintings.json"))
      scraped_artworks = GoogleArtworkScraper.new("spec/support/botticelli-paintings.html").scrape
      
      expect(scraped_artworks).to match(expected_result)
    end
  end

  describe "Scrape to file" do
    after(:example) do
      file = "spec/temp/botticelli-paintings.json"
      File.delete(file) if File.exists?(file)
    end
    
    it "should write results to JSON file" do
      GoogleArtworkScraper.new("spec/support/botticelli-paintings.html").scrape_to_file

      expect(File.exist?("spec/temp/botticelli-paintings.json")).to be(true)
    end
  end
end