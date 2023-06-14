describe "Test against other similar result pages" do
  describe '.scrape_data test-1' do
    let(:url) { File.join(__dir__, '../files', 'test-fast-and-furious.html') }

    it "returns a list of artworks" do
      scraped_data = Scraper.scrape_data(url)

      expect(scraped_data["artworks"]).to be_an(Array)

      first_artwork = scraped_data["artworks"].first

      expect(first_artwork).to include("name", "extensions", "link", "image")
      expect(first_artwork["name"]).to_not be_empty
      expect(first_artwork["extensions"]).to_not be_empty
      expect(first_artwork["link"]).to_not be_empty
      expect(first_artwork["image"]).to_not be_empty
    end
  end

  describe '.scrape_data test-2' do
    let(:url) { File.join(__dir__, '../files', 'test-harry-potter.html') }

    it "returns a list of artworks" do
      scraped_data = Scraper.scrape_data(url)

      expect(scraped_data["artworks"]).to be_an(Array)

      first_artwork = scraped_data["artworks"].first
      expect(first_artwork).to include("name", "extensions", "link", "image")
      expect(first_artwork["name"]).to_not be_empty
      expect(first_artwork["extensions"]).to_not be_empty
      expect(first_artwork["link"]).to_not be_empty
      expect(first_artwork["image"]).to_not be_empty
    end
  end
end