require "spec_helper"
require_relative "../artworks"

describe Artworks do
  describe "#payload" do
    context "with valid HTML containing artworks" do
      let(:html) { File.read("files/van-gogh-paintings.html") }
      let(:expected_payload) do
        JSON.parse(File.read("files/expected-array.json"), symbolize_names: true)
      end

      it "returns the expected payload structure" do
        artworks = described_class.new(html)
        payload = artworks.payload

        expect(payload).to be_a(Hash)
        expect(payload).to have_key(:artworks)
        expect(payload[:artworks]).to be_a(Array)
        expect(payload[:artworks].size).to be > 0
        expect(payload[:artworks].first).to be_a(Hash)
      end

      it "matches the expected data" do
        artworks = described_class.new(html)
        expect(artworks.payload).to match(expected_payload)
      end

      it "includes properly joined URLs in links" do
        artworks = described_class.new(html)
        links = artworks.payload[:artworks].map { |art| art[:link] }
        expect(links.first).to start_with("https://www.google.com")
        expect(links.first).to include("/search?")
      end
    end

    context "with empty or no artworks HTML" do
      let(:empty_html) { "" }
      let(:no_artworks_html) { "<html><body>No artworks here</body></html>" }

      it "returns empty artworks array for empty HTML" do
        artworks = described_class.new(empty_html)
        expect(artworks.payload[:artworks]).to eq([])
      end

      it "returns empty artworks array if no matching div" do
        artworks = described_class.new(no_artworks_html)
        expect(artworks.payload[:artworks]).to eq([])
      end
    end

    context "with malformed elements" do
      let(:malformed_html) do
        <<~HTML
          <div data-attrid="kc:/visual_art/visual_artist:works">
            <a href="/valid"><img alt="Valid" data-src="valid.jpg"></a>
            <a href="">No href</a>
            <a href="/noimg">No img</a>
            <a href="/noalt"><img></a>
          </div>
        HTML
      end

      it "skips anchors without href" do
        artworks = described_class.new(malformed_html)
        valid_art = artworks.payload[:artworks].first
        expect(valid_art[:link]).to start_with("https://www.google.com/valid")
        expect(artworks.payload[:artworks].size).to eq(2)
      end

      it "skips anchors without img" do
        artworks = described_class.new(malformed_html)
        expect(artworks.payload[:artworks].size).to eq(2)
      end

      it "includes artworks without alt (name nil, but compact removes key)" do
        artworks = described_class.new(malformed_html)
        noalt_art = artworks.payload[:artworks].detect { |a| a[:link].include?("/noalt") }
        expect(noalt_art).not_to have_key(:name)
      end
    end

    context "with deferred images" do
      let(:deferred_html) do
        <<~HTML
          <div data-attrid="kc:/visual_art/visual_artist:works">
            <a href="/deferred">
              <img id="img1" data-deferred="1" alt="Deferred Art">
              <script>var s='\\x68\\x74\\x74\\x70\\x73\\x3a\\x2f\\x2fexample.com/deferred.jpg';var ii=['img1'];</script>
            </a>
          </div>
        HTML
      end

      it "decodes deferred image src correctly" do
        artworks = described_class.new(deferred_html)
        art = artworks.payload[:artworks].first
        expect(art[:image]).to eq("https://example.com/deferred.jpg")
        expect(art[:name]).to eq("Deferred Art")
      end

      it "prioritizes data-src if present (no deferred)" do
        html_with_src = deferred_html.gsub('data-deferred="1"', 'data-src="direct.jpg"')
        artworks = described_class.new(html_with_src)
        expect(artworks.payload[:artworks].first[:image]).to eq("direct.jpg")
      end

      it "skips deferred if no matching script or bad regex" do
        bad_script_html = deferred_html.gsub("var s='", "var bad='")
        artworks = described_class.new(bad_script_html)
        expect(artworks.payload[:artworks].first[:image]).to be_nil
      end
    end
  end
end
