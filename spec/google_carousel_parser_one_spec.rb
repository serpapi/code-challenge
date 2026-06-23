require 'rspec'
require 'json'
require_relative '../lib/google_carousel_parser_one'

describe GoogleCarouselParserOne do
  shared_examples "a google carousel search result page" do |filepath, expected_key|
    let(:parser) { GoogleCarouselParserOne.new(filepath) }
    let(:result) { parser.parse }

    it "returns a hash containing the expected category key array" do
      expect(result).to be_a(Hash)
      expect(result[expected_key]).to be_an(Array)
      expect(result[expected_key]).not_to be_empty
    end

    it "validates that every item has a valid name, link array, and extensions array" do
      result[expected_key].each do |item|
        expect(item["name"]).to be_a(String)
        expect(item["name"]).not_to be_empty

        expect(item["link"]).to be_an(Array)
        expect(item["link"]).not_to be_empty
        item["link"].each do |url|
          expect(url).to be_a(String)
          expect(url).to start_with("https://www.google.com/search")
        end

        expect(item["extensions"]).to be_an(Array)
        item["extensions"].each do |ext|
          expect(ext).to be_a(String)
        end

        expect(item["image"]).to be_nil
      end
    end
  end

  describe "Van Gogh Paintings Carousel" do
    it_behaves_like "a google carousel search result page", "files/van-gogh-paintings.html", "artworks"
  end

  describe "Barack Obama Books Carousel" do
    it_behaves_like "a google carousel search result page", "spec/fixtures/barack-obama-books.html", "books"
  end

  describe "Taylor Swift Albums Carousel" do
    it_behaves_like "a google carousel search result page", "spec/fixtures/taylor-swift-albums.html", "albums"
  end

  describe "Empty / No Carousel Page" do
    let(:empty_file) { "spec/fixtures/empty.html" }

    before do
      File.write(empty_file, "<html><body><h1>No Carousel Here</h1></body></html>")
    end

    after do
      File.delete(empty_file) if File.exist?(empty_file)
    end

    it "returns an empty hash" do
      result = GoogleCarouselParserOne.new(empty_file).parse
      expect(result).to eq({})
    end
  end
end
