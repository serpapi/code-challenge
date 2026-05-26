require "spec_helper"
require "carousel_item"

RSpec.describe CarouselItem do
  let(:node) { Nokolexbor::HTML('<div class="iELo6"></div>').css(".iELo6").first }
  subject(:item) { described_class.new(node, {}) }

  describe "#to_h when fields are missing" do
    it "returns nil for name" do
      expect(item.to_h[:name]).to be_nil
    end

    it "omits extensions key when there is no date" do
      expect(item.to_h).not_to have_key(:extensions)
    end

    it "returns nil for link" do
      expect(item.to_h[:link]).to be_nil
    end

    it "returns nil for image" do
      expect(item.to_h[:image]).to be_nil
    end
  end
end
