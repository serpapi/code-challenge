require "spec_helper"

RSpec.describe CarouselParser do
  subject(:parser) do
    described_class.new(html_string:)
  end

  let(:html_string) { File.read("spec/fixtures/van-gogh-paintings.html") }
  let(:expected_result) { JSON.parse(File.read("spec/fixtures/expected-array.json")) }

  describe "#initialize" do
    it "assigns the correct variables" do
      expect(parser.instance_variable_get(:@html_string)).to eq(html_string)
    end
  end

  describe "#call" do
    it "the first carousel item is parsed correctly" do
      actual_first = parser.call["artworks"][0]
      expected_first = expected_result["artworks"][0]

      expect(actual_first[:name]).to match(expected_first["name"])
      expect(actual_first[:link]).to match(expected_first["link"])
      expect(actual_first[:image]).to match(expected_first["image"])
    end
  end
end
