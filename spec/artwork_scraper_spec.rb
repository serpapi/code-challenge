# spec/artwork_scraper_spec.rb
require "spec_helper"

describe ArtworkScraper do
  let(:scraper) { ArtworkScraper.new }
  let(:sample_doc) do
    Nokogiri.HTML5(File.read("spec/fixtures/sample_artwork.html"))
  end

  describe "#fetch_google_results" do
    it "returns a Nokogiri document" do
      VCR.use_cassette("google_search_results") do
        result = scraper.fetch_google_results("Van Gogh artwork")
        expect(result).to be_a(Nokogiri::HTML5::Document)
      end
    end
  end

  describe "#find_script_elements_with_set_image_srcs" do
    it "returns an array of indices" do
      indices = scraper.find_script_elements_with_set_image_srcs(sample_doc)
      expect(indices).to eq([1, 3, 5])
    end
  end

  describe "#build_image_id_to_data_image_src_map" do
    it "returns a hash of image ids and data image srcs" do
      data_image_map = scraper.build_image_id_to_data_image_src_map(sample_doc)
      expect(data_image_map).to be_a(Hash)
      expect(data_image_map.keys).to include("_fF8wZLeOKbipqtsPgt220A8_255")
    end
  end

  describe "#extract_artwork_data_from_file" do
    it "returns an array of artwork data hashes" do
      artwork_data = scraper.extract_artwork_data_from_file(sample_doc)
      expect(artwork_data).to be_a(Hash)
      expect(artwork_data[:artworks]).to be_an(Array)
      expect(artwork_data[:artworks].first).to have_key("name")
    end
  end

  describe "#extract_artwork_data" do
    it "returns an array of artwork data hashes" do
      VCR.use_cassette("google_search_results") do
        doc = scraper.fetch_google_results("Van Gogh artwork")
        artwork_data = scraper.extract_artwork_data(doc)
        expect(artwork_data).to be_a(Hash)
        expect(artwork_data[:artworks]).to be_an(Array)
        expect(artwork_data[:artworks].first).to have_key("name")
      end
    end
  end

  describe "#download_images_and_save_json" do
    let(:artwork_data) do
      {
        artworks: [
          {
            "name" => "Sample Art",
            "image" => "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD"
          }
        ]
      }
    end

    it "saves artwork data as a JSON file" do
      scraper.download_images_and_save_json(artwork_data, "SampleArtist")
      expect(File.exist?("SampleArtist_artworks/artworks.json")).to be true
    end
  end
end
