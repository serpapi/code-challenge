require "spec_helper"
require "carousel_extractor"

RSpec.describe CarouselExtractor do
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
      </html>
    HTML
  end

  subject(:results) { described_class.new(html).extract }

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
