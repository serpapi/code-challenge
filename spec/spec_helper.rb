require 'nokogiri'
require_relative '../lib/scraper'
require 'json'

RSpec.describe PaintingScraper do
  let(:html_path) { '../files/van-gogh-paintings.html' }
  let(:empty_html_path) { '../files/empty-html.html' }
  let(:van_gogh_missing_first_elements_path) { '../files/van-gogh-paintings-missing-first.html' }
  let(:scraper) { PaintingScraper.new(html_path) }
  let(:expected_output_path) { '../files/expected-array.json' }

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

    it 'returns an empty array if there are no paintings' do
      fallback_scraper = PaintingScraper.new(empty_html_path)
      result = fallback_scraper.parse_html
      expect(result[:artworks]).to be_empty
    end

    it 'falls back to default values if the name is missing' do
      fallback_scraper = PaintingScraper.new(van_gogh_missing_first_elements_path)
      result = fallback_scraper.parse_html
      artwork = result[:artworks].first
      expect(artwork[:name]).to eq("Name not found")
    end

    it 'matches the expected array' do
      file_content = File.read(expected_output_path)
      expected_artworks = JSON.parse(file_content)["artworks"]

      scraper = PaintingScraper.new(html_path)
      my_paintings = scraper.parse_html[:artworks]

      expected_artworks.each do |expected_painting|
        my_painting = my_paintings.find { |p| p[:name] == expected_painting["name"] }
        if my_painting
          expect(my_painting[:link]).to eq(expected_painting["link"])
          expect(my_painting[:image]).to eq(expected_painting["image"])
          expect(my_painting[:extensions]).to eq(expected_painting["extensions"])
        else
          fail("Painting not found: #{expected_painting["name"]}")
        end
      end
    end
  end
end