require_relative 'spec_helper'

describe "Scraper" do
  describe "blah" do
    it "should matched sample JSON file" do
      expected_result = JSON.load(File.read("spec/support/van-gogh-paintings.json"))
      scraped_artworks = GoogleArtworkScraper.new("files/van-gogh-paintings.html").scrape
      
      expect(scraped_artworks).to match(expected_result)
    end
  end
end