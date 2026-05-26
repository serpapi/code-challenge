require "spec_helper"
require "carousel_extractor"

RSpec.describe CarouselExtractor do
  context "with Z8r5Gb layout (albums carousel)" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,ALB1==';var ii=['_alb1'];var r='';_setImagesSrc(ii,s,r);})();</script>
          <div class="Z8r5Gb">
            <a href="https://www.google.com/search?q=Fearless">
              <img class="d7ENZc" id="_alb1">
              <div class="JjtOHd">Fearless</div>
              <div class="cHaqb">2008</div>
            </a>
          </div>
          <div class="Z8r5Gb">
            <a href="https://www.google.com/search?q=1989">
              <img class="d7ENZc" data-src="https://encrypted-tbn0.gstatic.com/images?q=1989">
              <div class="JjtOHd">1989</div>
            </a>
          </div>
        </html>
      HTML
    end

    subject(:results) { described_class.new(html).extract }

    it "detects Z8r5Gb layout and extracts name" do
      expect(results[0][:name]).to eq("Fearless")
    end

    it "extracts extension (year) for Z8r5Gb items" do
      expect(results[0][:extensions]).to eq(["2008"])
    end

    it "extracts base64 image from script tag" do
      expect(results[0][:image]).to eq("data:image/jpeg;base64,ALB1==")
    end

    it "extracts data-src for lazy-loaded Z8r5Gb items" do
      expect(results[1][:image]).to eq("https://encrypted-tbn0.gstatic.com/images?q=1989")
    end

    it "omits extensions when year is absent" do
      expect(results[1]).not_to have_key(:extensions)
    end

    it "preserves absolute links unchanged" do
      expect(results[0][:link]).to eq("https://www.google.com/search?q=Fearless")
    end
  end
end
