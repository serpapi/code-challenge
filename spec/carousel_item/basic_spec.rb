require "spec_helper"
require "carousel_item"
require "layouts/i_elo6"

RSpec.describe CarouselItem do
  let(:html) do
    <<~HTML
      <div class="iELo6">
        <a href="/search?q=The+Starry+Night">
          <img class="taFZJe" src="data:image/jpeg;base64,FAKEBASE64==">
          <div class="pgNMRc">The Starry Night</div>
          <div class="cxzHyb">1889</div>
        </a>
      </div>
    HTML
  end

  let(:node) { Nokolexbor::HTML(html).css(".iELo6").first }
  subject(:item) { described_class.new(node, {}, Layouts::IELo6.new) }

  describe "#to_h" do
    it "extracts the name" do
      expect(item.to_h[:name]).to eq("The Starry Night")
    end

    it "extracts extensions as an array" do
      expect(item.to_h[:extensions]).to eq(["1889"])
    end

    it "extracts the link" do
      expect(item.to_h[:link]).to include("q=The+Starry+Night")
    end
  end
end
