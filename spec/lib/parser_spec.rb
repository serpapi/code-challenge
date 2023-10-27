require "spec_helper"


RSpec.describe Parser do
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
end
