# frozen_string_literal: true

RSpec.describe CarouselExtractor do
  let(:artworks) { described_class.call(fixture_input) }
  let(:fixture_input) { File.read("#{FILES}/van-gogh-paintings.html") }
  let(:fixture_expected) { File.read("#{FILES}/expected-array.json") }
  let(:expected) { JSON.parse(fixture_expected).fetch("artworks") }

  describe "van-gogh-paintings.html (challenge fixture)" do
    it "reproduces the expected artworks array exactly" do
      expect(artworks).to eql(expected)
    end

    describe "first artwork" do
      subject(:first) { artworks.first }

      let(:starry_night) { expected.first }

      it("has a name") { expect(first["name"]).to eql(starry_night["name"]) }
      it("has a link") { expect(first["link"]).to eql(starry_night["link"]) }
      it("has extensions") do
        expect(first["extensions"]).to eql(starry_night["extensions"])
      end
      it("has an inline base64 image") do
        expect(first["image"]).to eql(starry_night["image"])
      end
    end

    it "omits extensions for yearless paintings rather than emitting []" do
      yearless = artworks.reject { |a| a.key?("extensions") }
      expect(yearless.map { |a| a["name"] }).to include("Sunflowers")
      expect(yearless).to all(satisfy { |a| !a.key?("extensions") })
    end

    it "needs no extra HTTP requests (every image is inline data: or an in-page URL)" do
      expect(artworks).to all(satisfy { |a|
        a["image"].start_with?("data:image", "https://")
      })
    end
  end

  # Mirrors the per-artwork assertions from SerpApi's referenced Monet spec
  # (which also hits the live API and covers the whole knowledge graph).
  describe "conforms to SerpApi's referenced artwork contract" do
    it "returns a non-empty artworks Array" do
      expect(artworks).to be_an(Array)
      expect(artworks).to_not be_empty
    end

    it "first artwork has name/extensions/link/image of the expected types" do
      first = artworks.first
      expect(first["name"]).to be_a(String)
      expect(first["name"]).to_not be_empty
      expect(first["extensions"]).to be_a(Array)
      expect(first["extensions"]).to_not be_empty
      expect(first["link"]).to be_a(String)
      expect(first["link"]).to_not be_empty
      expect(first["image"]).to be_a(String)
      expect(first["image"]).to_not be_empty
    end
  end
end
