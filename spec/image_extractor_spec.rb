require "spec_helper"
require "image_extractor"

RSpec.describe ImageExtractor do
  let(:html) do
    <<~HTML
      <html>
        <script>(function(){var s='data:image/jpeg;base64,FAKEBASE64==';var ii=['_abc123'];var r='';_setImagesSrc(ii,s,r);})();</script>
        <script>(function(){var s='data:image/jpeg;base64,OTHERBASE64==';var ii=['_xyz789'];var r='';_setImagesSrc(ii,s,r);})();</script>
      </html>
    HTML
  end

  let(:doc) { Nokolexbor::HTML(html) }
  subject(:images) { described_class.new(doc) }

  it "looks up an image by id" do
    expect(images["_abc123"]).to eq("data:image/jpeg;base64,FAKEBASE64==")
  end

  it "looks up a different image by id" do
    expect(images["_xyz789"]).to eq("data:image/jpeg;base64,OTHERBASE64==")
  end

  it "returns nil for an unknown id" do
    expect(images["_unknown"]).to be_nil
  end

  context "when the base64 string contains JavaScript hex escapes" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,FAKEBASE64\\x3d\\x3d';var ii=['_esc123'];var r='';_setImagesSrc(ii,s,r);})();</script>
        </html>
      HTML
    end

    it "unescapes \\x3d to =" do
      expect(images["_esc123"]).to eq("data:image/jpeg;base64,FAKEBASE64==")
    end
  end
end
