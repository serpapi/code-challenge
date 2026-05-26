require "spec_helper"
require "carousel_item"

RSpec.describe CarouselItem do
  let(:html) do
    <<~HTML
      <div class="iELo6">
        <a href="#">
          <img class="taFZJe" id="_img1">
        </a>
      </div>
    HTML
  end

  let(:node) { Nokolexbor::HTML(html).css(".iELo6").first }

  describe "#image" do
    context "when img has an id (jpeg via script tag)" do
      subject(:item) { described_class.new(node, { "_img1" => "data:image/jpeg;base64,FAKEBASE64==" }) }

      it "returns the base64 jpeg from ImageExtractor" do
        expect(item.to_h[:image]).to eq("data:image/jpeg;base64,FAKEBASE64==")
      end
    end

    context "when img has no id but has data-src (lazy-loaded)" do
      let(:html) do
        <<~HTML
          <div class="iELo6">
            <a href="#">
              <img class="taFZJe" data-src="https://encrypted-tbn0.gstatic.com/images?q=fake">
            </a>
          </div>
        HTML
      end

      subject(:item) { described_class.new(node, {}) }

      it "returns the data-src url" do
        expect(item.to_h[:image]).to eq("https://encrypted-tbn0.gstatic.com/images?q=fake")
      end
    end

    context "when img has no id (gif placeholder)" do
      subject(:item) { described_class.new(node, {}) }

      it "returns nil" do
        expect(item.to_h[:image]).to be_nil
      end
    end
  end
end
