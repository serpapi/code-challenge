require "spec_helper"
require "carousel_extractor"

RSpec.describe CarouselExtractor do
  describe "unknown layout" do
    it "raises UnknownLayoutError when no recognized layout is found" do
      expect { described_class.new("<html></html>").extract }
        .to raise_error(CarouselExtractor::UnknownLayoutError)
    end
  end

  context "with iELo6 layout (paintings carousel)" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,IMG1==';var ii=['_img1'];var r='';_setImagesSrc(ii,s,r);})();</script>
          <div class="iELo6">
            <a href="/search?q=Painting+One">
              <img class="taFZJe" id="_img1">
              <div class="pgNMRc">Painting One</div>
              <div class="cxzHyb">1888</div>
            </a>
          </div>
          <div class="iELo6">
            <a href="/search?q=Painting+Two">
              <img class="taFZJe" data-src="https://encrypted-tbn0.gstatic.com/images?q=fake">
              <div class="pgNMRc">Painting Two</div>
              <div class="cxzHyb">1889</div>
            </a>
          </div>
          <div class="iELo6">
            <a href="/search?q=Painting+Three">
              <img class="taFZJe">
              <div class="pgNMRc">Painting Three</div>
            </a>
          </div>
          <div class="iELo6"></div>
        </html>
      HTML
    end

    subject(:results) { described_class.new(html).extract }

    it "filters out blank items (no name or link)" do
      expect(results.length).to eq(3)
    end

    it "extracts image from script tag for visible items" do
      expect(results[0][:image]).to eq("data:image/jpeg;base64,IMG1==")
    end

    it "extracts data-src url for lazy-loaded items" do
      expect(results[1][:image]).to eq("https://encrypted-tbn0.gstatic.com/images?q=fake")
    end

    it "returns nil image when neither source is available" do
      expect(results[2][:image]).to be_nil
    end

    it "omits extensions when no date is present" do
      expect(results[2]).not_to have_key(:extensions)
    end
  end

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
