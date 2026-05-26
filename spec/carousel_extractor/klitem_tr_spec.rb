require "spec_helper"
require "carousel_extractor"

RSpec.describe CarouselExtractor do
  context "with klitem-tr layout (movies carousel)" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,MOV1==';var ii=['_mov1'];var r='';_setImagesSrc(ii,s,r);})();</script>
          <a class="klitem-tr" href="https://www.google.com/search?q=Brazil" aria-label="Brazil">
            <div class="klitem">
              <img class="VeBrne" id="_mov1">
              <div class="FozYP">Brazil</div>
              <div class="FozYP">1985</div>
            </div>
          </a>
          <a class="klitem-tr" href="https://www.google.com/search?q=12+Monkeys" aria-label="12 Monkeys">
            <div class="klitem">
              <img class="VeBrne" data-src="https://encrypted-tbn0.gstatic.com/images?q=monkeys">
              <div class="FozYP">12 Monkeys</div>
              <div class="FozYP">1995</div>
            </div>
          </a>
        </html>
      HTML
    end

    subject(:results) { described_class.new(html).extract }

    it "detects klitem-tr layout and extracts name from aria-label" do
      expect(results[0][:name]).to eq("Brazil")
    end

    it "extracts extension from last FozYP" do
      expect(results[0][:extensions]).to eq(["1985"])
    end

    it "extracts link from the item anchor href" do
      expect(results[0][:link]).to eq("https://www.google.com/search?q=Brazil")
    end

    it "extracts base64 image from script tag" do
      expect(results[0][:image]).to eq("data:image/jpeg;base64,MOV1==")
    end

    it "extracts data-src for lazy-loaded items" do
      expect(results[1][:image]).to eq("https://encrypted-tbn0.gstatic.com/images?q=monkeys")
    end
  end
end
