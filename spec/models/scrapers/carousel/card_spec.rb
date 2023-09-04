require "spec_helper"
require "scrapers/carousel/card"
require "json"

describe Scrapers::Carousel::Card do
  let(:node) { Nokogiri::HTML(File.read("spec/fixtures/card.html")).css("a").first }
  let(:subject) { Scrapers::Carousel::Card.new(node) }

  let(:expected) { JSON.load(File.open("spec/fixtures/expected-array.json"))["artworks"][0] }

  context "van gogh painting card" do
    it "parses the name correctly" do
      expect(expected["name"]).to eq(subject.name)
    end

    it "parses the extensions correctly" do
      expect(expected["extensions"]).to eq(subject.extensions)
    end

    it "parses the link correctly" do
      expect(expected["link"]).to include(subject.path)
    end

    it "parses the image correctly" do
      expect(expected["image"]).to eq(subject.image_url)
    end
  end

  context "empty extensions" do
    let(:node) { Nokogiri::HTML(File.read("spec/fixtures/card_no_extensions.html")).css("a").first }
    let(:subject) { Scrapers::Carousel::Card.new(node) }

    it "returns nil" do
      expect(nil).to eq(subject.to_hash[:extensions])
    end
  end
end
