require 'rspec'
require 'json'
require_relative '../lib/google_carousel_parser_two'

describe GoogleCarouselParserTwo do
  shared_examples "a google carousel search result page" do |filepath, expected_key|
    let(:parser) { GoogleCarouselParserTwo.new(filepath) }
    let(:result) { parser.parse }

    it "returns a hash containing the expected category key array" do
      expect(result).to be_a(Hash)
      expect(result[expected_key]).to be_an(Array)
      expect(result[expected_key]).not_to be_empty
    end

    it "validates that every item has a valid name, link, and optionally extensions/image" do
      result[expected_key].each do |item|
        expect(item["name"]).to be_a(String)
        expect(item["name"]).not_to be_empty

        expect(item["link"]).to be_a(String)
        expect(item["link"]).to start_with("https://www.google.com/search")

        expect(item["extensions"]).to be_an(Array)
        item["extensions"].each do |ext|
          expect(ext).to be_a(String)
        end

        if item["image"]
          expect(item["image"]).to be_a(String)
          expect(item["image"]).to start_with("data:image/").or start_with("https://encrypted-tbn")
        end
      end
    end
  end

  describe "Van Gogh Paintings Carousel" do
    it_behaves_like "a google carousel search result page", "files/van-gogh-paintings.html", "artworks"

    it "exactly matches the expected JSON output" do
      expected = JSON.parse(File.read("files/expected-array.json"))
      actual = GoogleCarouselParserTwo.new("files/van-gogh-paintings.html").parse

      expect(actual["artworks"].size).to eq(expected["artworks"].size)

      actual["artworks"].each_with_index do |artwork, index|
        exp = expected["artworks"][index]
        expect(artwork["name"]).to eq(exp["name"])
        expect(artwork["link"]).to eq(exp["link"])
        expect(artwork["extensions"]).to eq(exp["extensions"] || [])
        expect(artwork["image"]).to eq(exp["image"])
      end
    end
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
      result = GoogleCarouselParserTwo.new(empty_file).parse
      expect(result).to eq({})
    end
  end
end
