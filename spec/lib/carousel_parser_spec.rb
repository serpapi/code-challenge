require "spec_helper"

RSpec.describe CarouselParser do
  subject(:parser) do
    described_class.new(html_string:)
  end

  let(:html_string) { "foo" }

  describe "#initialize" do
    it "assigns the correct variables" do
      expect(parser.instance_variable_get(:@html_string)).to eq(html_string)
    end
  end
end
