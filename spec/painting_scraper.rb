require 'nokogiri'
require_relative '../lib/scraper'

RSpec.describe PaintingScraper do
  let(:html_path) { '../files/van-gogh-paintings.html' } 
  let(:empty_html_path) { '../files/empty-html.html' } 
  let(:van_gogh_missing_first_elements_path) { '../files/van-gogh-paintings-missing-first.html' } 
  let(:scraper) { PaintingScraper.new(html_path) }

  describe '#parse_html' do
    it 'returns a hash with artworks' do
      result = scraper.parse_html
      expect(result).to be_a(Hash)
      expect(result).to have_key(:artworks)
    end

    it 'contains at least one artwork with correct structure' do
      result = scraper.parse_html
      artwork = result[:artworks].first

      expect(artwork).to include(:name, :extensions, :link, :image)
      expect(artwork[:extensions]).to be_an(Array)
    end

    it 'it returns an empty array if theres no paintings' do
      fallback_scraper = PaintingScraper.new(empty_html_path)
      result = fallback_scraper.parse_html
      artwork = result[:artworks].first

      expect(result[:artworks]).to be_empty
    end

    # Copied van-gogh and removed the first paintings name
    it 'falls back to default values if the name is missing' do
      fallback_scraper = PaintingScraper.new(van_gogh_missing_first_elements_path)
      result = fallback_scraper.parse_html
      artwork = result[:artworks].first

      expect(artwork[:name]).to eq("Name not found")
    end
  end
end
