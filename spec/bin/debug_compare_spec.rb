require "spec_helper"
require "debug_comparator"

RSpec.describe DebugComparator do
  let(:html) do
    <<~HTML
      <html>
        <script>(function(){var s='data:image/jpeg;base64,IMG1==';var ii=['_img1'];var r='';_setImagesSrc(ii,s,r);})();</script>
        <div class="iELo6">
          <a href="/search?q=Starry+Night">
            <img class="taFZJe" id="_img1">
            <div class="pgNMRc">The Starry Night</div>
            <div class="cxzHyb">1889</div>
          </a>
        </div>
      </html>
    HTML
  end

  let(:matching_expected) do
    [{ "name" => "The Starry Night", "extensions" => ["1889"],
       "link" => "https://www.google.com/search?q=Starry+Night",
       "image" => "data:image/jpeg;base64,IMG1==" }]
  end

  let(:mismatched_expected) do
    [{ "name" => "Wrong Name", "extensions" => ["1889"],
       "link" => "https://www.google.com/search?q=Starry+Night",
       "image" => "data:image/jpeg;base64,IMG1==" }]
  end

  context "when all fields match" do
    subject(:comparator) { described_class.new(html, matching_expected) }

    it "reports no mismatches" do
      expect(comparator.mismatches).to eq(0)
    end
  end

  context "when a field does not match" do
    subject(:comparator) { described_class.new(html, mismatched_expected) }

    it "reports a mismatch" do
      expect(comparator.mismatches).to eq(1)
    end
  end
end
