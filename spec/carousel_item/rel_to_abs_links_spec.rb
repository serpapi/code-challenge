require "spec_helper"
require "carousel_item"

RSpec.describe CarouselItem do
  let(:html) do
    <<~HTML
      <div class="iELo6">
        <a href="/search?q=The+Starry+Night"></a>
      </div>
    HTML
  end

  let(:node) { Nokolexbor::HTML(html).css(".iELo6").first }
  subject(:item) { described_class.new(node, {}) }

  describe "link" do
    it "converts relative links to absolute" do
      expect(item.to_h[:link]).to eq("https://www.google.com/search?q=The+Starry+Night")
    end
  end
end
