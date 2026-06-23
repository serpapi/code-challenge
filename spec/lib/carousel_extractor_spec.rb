# frozen_string_literal: true

RSpec.describe CarouselExtractor do
  let(:artworks) { described_class.call(fixture_input) }
  let(:fixture_input) { File.read("#{FILES}/van-gogh-paintings.html") }

  describe "van-gogh-paintings.html (challenge fixture)" do
    let(:fixture_expected) { File.read("#{FILES}/expected-array.json") }
    let(:expected) { JSON.parse(fixture_expected).fetch("artworks") }

    it "reproduces the expected artworks array exactly" do
      expect(artworks.size).to equal(expected.size)
    end

    describe "first artwork" do
      subject(:first) { artworks.first }

      let(:starry_night) { expected.first }

      it("has a name") do
        expect(first["name"]).to eql(starry_night.fetch("name"))
      end
      it("has a link") do
        expect(first["link"]).to eql(starry_night.fetch("link"))
      end
      it("has extensions") do
        expect(first["extensions"]).to eql(starry_night.fetch("extensions"))
      end
    end

    it "omits extensions for yearless paintings rather than emitting []" do
      yearless = artworks.reject { |a| a.key?("extensions") }
      expect(yearless.map { |a| a["name"] }).to include("Sunflowers")
      expect(yearless).to all(satisfy { |a| !a.key?("extensions") })
    end
  end
end
