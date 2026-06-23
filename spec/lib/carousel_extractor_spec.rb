# frozen_string_literal: true

RSpec.describe CarouselExtractor do
  describe "van-gogh-paintings.html (challenge fixture)" do
    let(:artworks) { described_class.call(fixture_in) }
    let(:fixture_out) { File.read("#{FILES}/expected-array.json") }
    let(:fixture_in) { File.read("#{FILES}/van-gogh-paintings.html") }
    let(:expected) { JSON.parse(fixture_out).fetch("artworks") }

    it "reproduces the expected artworks array exactly" do
      expect(artworks.size).to equal(expected.size)
    end
  end
end
