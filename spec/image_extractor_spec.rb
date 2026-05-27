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

  context "when the script uses double-quoted strings" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s="data:image/jpeg;base64,DQBASE64==";var ii=["_dq123"];var r="";_setImagesSrc(ii,s,r);})();</script>
        </html>
      HTML
    end

    it "extracts the image" do
      expect(images["_dq123"]).to eq("data:image/jpeg;base64,DQBASE64==")
    end
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

  context "when the script has mismatched quotes" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,MISMATCH";var ii=['_bad'];var r='';_setImagesSrc(ii,s,r);})();</script>
        </html>
      HTML
    end

    it "does not extract the image" do
      expect(images["_bad"]).to be_nil
    end
  end

  context "when a script tag contains multiple ids" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,SHARED==';var ii=['_id1','_id2','_id3'];var r='';_setImagesSrc(ii,s,r);})();</script>
        </html>
      HTML
    end

    it "maps all ids to the same image" do
      expect(images["_id1"]).to eq("data:image/jpeg;base64,SHARED==")
      expect(images["_id2"]).to eq("data:image/jpeg;base64,SHARED==")
      expect(images["_id3"]).to eq("data:image/jpeg;base64,SHARED==")
    end
  end

  context "when a variable is inserted between s and ii" do
    let(:html) do
      <<~HTML
        <html>
          <script>(function(){var s='data:image/jpeg;base64,FAKEBASE64==';var _x=1;var ii=['_abc123'];var r='';_setImagesSrc(ii,s,r);})();</script>
        </html>
      HTML
    end

    it "still extracts the image" do
      expect(images["_abc123"]).to eq("data:image/jpeg;base64,FAKEBASE64==")
    end
  end

  context "when no script tags contain image data" do
    let(:html) do
      <<~HTML
        <html>
          <script>console.log('nothing here');</script>
        </html>
      HTML
    end

    it "returns an empty map" do
      expect(images["_anything"]).to be_nil
    end
  end
end
