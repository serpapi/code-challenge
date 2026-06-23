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

      it("has a name") { expect(first["name"]).to eql(starry_night["name"]) }
    end
  end
end
