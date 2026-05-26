require "spec_helper"
require "carousel_extractor"

RSpec.describe CarouselExtractor do
  context "with jCuzJd layout (actors carousel)" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,ACT1==';var ii=['_act1'];var r='';_setImagesSrc(ii,s,r);})();</script>
          <div class="jCuzJd">
            <a href="https://www.google.com/search?q=Joaquin+Phoenix">
              <img class="d7ENZc" id="_act1">
              <div class="JjtOHd">Joaquin Phoenix</div>
              <div class="cHaqb">Theodore</div>
            </a>
          </div>
          <div class="jCuzJd">
            <a href="https://www.google.com/search?q=Amy+Adams">
              <img class="d7ENZc" data-src="https://encrypted-tbn0.gstatic.com/images?q=amy">
              <div class="JjtOHd">Amy Adams</div>
            </a>
          </div>
        </html>
      HTML
    end

    subject(:results) { described_class.new(html).extract }

    it "detects jCuzJd layout and extracts name" do
      expect(results[0][:name]).to eq("Joaquin Phoenix")
    end

    it "extracts extension (role) for jCuzJd items" do
      expect(results[0][:extensions]).to eq(["Theodore"])
    end

    it "extracts base64 image from script tag" do
      expect(results[0][:image]).to eq("data:image/jpeg;base64,ACT1==")
    end

    it "extracts data-src for lazy-loaded jCuzJd items" do
      expect(results[1][:image]).to eq("https://encrypted-tbn0.gstatic.com/images?q=amy")
    end

    it "omits extensions when role is absent" do
      expect(results[1]).not_to have_key(:extensions)
    end

    it "preserves absolute links unchanged" do
      expect(results[0][:link]).to eq("https://www.google.com/search?q=Joaquin+Phoenix")
    end
  end
end
