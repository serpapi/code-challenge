# frozen_string_literal: true

require "json"

RSpec.describe Code::Challenge do
  it "has a version number" do
    expect(Code::Challenge::VERSION).not_to be nil
  end

  describe ".parse_webpage" do
    let(:html) { File.read(File.expand_path("../../files/van-gogh-paintings.html", __dir__)) }
    let(:expected) { JSON.load_file(File.expand_path("../../files/expected-array.json", __dir__))["artworks"] }
    let(:artworks) { described_class.parse_webpage(html) }

    it "extracts all paintings from the Van Gogh results page" do
      expect(artworks).to eq(expected)
    end

    it "returns items with name, link, and image" do
      expect(artworks).not_to be_empty
      artworks.each do |item|
        expect(item).to include("name", "link", "image")
        expect(item["name"]).to be_a(String)
        expect(item["name"]).not_to be_empty
        expect(item["link"]).to start_with("https://www.google.com/search")
        expect(item["image"]).to match(%r{\A(?:data:image/|https://)})
      end
    end

    it "includes extensions when a date is present" do
      dated = artworks.find { |item| item["name"] == "The Starry Night" }
      expect(dated["extensions"]).to eq(["1889"])
    end

    it "omits extensions when no date is shown" do
      undated = artworks.find { |item| item["name"] == "Sunflowers" }
      expect(undated).not_to have_key("extensions")
    end
  end

  describe "additional carousel layouts" do
    Dir[File.expand_path("../fixtures/carousel_*.html", __dir__)].sort.each do |fixture_path|
      fixture_name = File.basename(fixture_path, ".html")

      it "parses #{fixture_name}" do
        html = File.read(fixture_path)
        expected = JSON.load_file(fixture_path.sub(/\.html\z/, ".json"))

        expect(described_class.parse_webpage(html)).to eq(expected)
      end
    end
  end
end
