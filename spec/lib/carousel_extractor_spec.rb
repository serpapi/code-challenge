# frozen_string_literal: true

RSpec.describe CarouselExtractor do
  let(:artworks) { described_class.call(fixture_input) }
  let(:fixture_input) { File.read("#{FILES}/van-gogh-paintings.html") }
  let(:fixture_expected) { File.read("#{FILES}/expected-array.json") }
  let(:expected) { JSON.parse(fixture_expected).fetch("artworks") }

  def entry_looks_valid?(entry)
    entry[:name].to_s != "" &&
      entry[:link].to_s.start_with?("https://www.google.com/search") &&
      entry[:image].to_s.start_with?("data:image")
  end

  describe "van-gogh-paintings.html (challenge fixture)" do
    it "reproduces the expected artworks array exactly" do
      expect(artworks.to_json).to eql(expected.to_json)
    end

    describe "first artwork" do
      subject(:first) { artworks.first }

      let(:starry_night) { expected.first }

      it("has a name") { expect(first[:name]).to eql(starry_night["name"]) }
      it("has a link") { expect(first[:link]).to eql(starry_night["link"]) }
      it("has extensions") do
        expect(first[:extensions]).to eql(starry_night["extensions"])
      end
      it("has an inline base64 image") do
        expect(first[:image]).to eql(starry_night["image"])
      end
    end

    it "omits extensions for yearless paintings rather than emitting []" do
      yearless = artworks.reject { |a| a.key?(:extensions) }
      expect(yearless.map { |a| a[:name] }).to include("Sunflowers")
      expect(yearless).to all(satisfy { |a| !a.key?(:extensions) })
    end

    it "needs no extra HTTP requests (every image is inline data: or an in-page URL)" do
      expect(artworks).to all(satisfy { |a|
        a[:image].start_with?("data:image", "https://")
      })
    end
  end

  # Mirrors the per-artwork assertions from SerpApi's referenced Monet spec
  # (which also hits the live API and covers the whole knowledge graph).
  describe "conforms to SerpApi's referenced artwork contract" do
    it "returns a non-empty artworks Array" do
      expect(artworks).to be_an(Array)
      expect(artworks).to_not be_empty
    end

    it "first artwork has name/extensions/link/image of the expected types" do
      first = artworks.first
      expect(first[:name]).to be_a(String)
      expect(first[:name]).to_not be_empty
      expect(first[:extensions]).to be_a(Array)
      expect(first[:extensions]).to_not be_empty
      expect(first[:link]).to be_a(String)
      expect(first[:link]).to_not be_empty
      expect(first[:image]).to be_a(String)
      expect(first[:image]).to_not be_empty
    end
  end

  describe "alternate carousel type: Grateful Dead albums" do
    let(:albums) do
      described_class.call(File.read("#{FIXTURES}/grateful_dead_albums.html"))
    end

    it "extracts the albums carousel via the music attrid" do
      expect(albums.size).to eql(12)
    end

    it "fills name (from the text div) + link + image for every album" do
      expect(albums).to all(satisfy(&method(:entry_looks_valid?)))
    end

    it "captures release years as extensions" do
      blues = albums.find { |a| a[:name] == "Blues for Allah" }
      expect(blues[:extensions]).to eql(["1975"])
    end
  end

  describe "alternate carousel type: Frank Lloyd Wright buildings (no dates)" do
    let(:buildings) { described_class.call(building_fixture) }
    let(:building_fixture) do
      File.read("#{FIXTURES}/frank_lloyd_wright_buildings.html")
    end

    it "extracts the buildings carousel via the architect attrid" do
      expect(buildings.size).to eql(12)
    end

    it "omits extensions across the entire carousel" do
      expect(buildings).to all(satisfy { |a| !a.key?(:extensions) })
    end

    it "still fills name + link + base64 image for every building" do
      expect(buildings).to all(satisfy(&method(:entry_looks_valid?)))
    end
  end

  describe "alternate carousel type: Breaking Bad cast" do
    let(:cast) { described_class.call(cast_fixture) }
    let(:cast_fixture) { File.read("#{FIXTURES}/breaking_bad_cast.html") }

    it "extracts the cast carousel via the tv_program attrid" do
      expect(cast.size).to eql(8)
    end

    it "puts the actor in name and the character in extensions" do
      cranston = cast.find { |a| a[:name] == "Bryan Cranston" }
      expect(cranston[:extensions]).to eql(["Walter White"])
    end

    it "fills name + link + base64 image for every cast member" do
      expect(cast).to all(satisfy(&method(:entry_looks_valid?)))
    end
  end

  describe "non-carousel / wrong-module pages (negatives: locator must not false-positive)" do
    it "returns [] for an organic/ads SERP (Mark Gonzales)" do
      html = File.read("#{FIXTURES}/mark_gonzales_skateboard_art.html")
      expect(described_class.call(html)).to eql([])
    end

    # Unilever's only carousel-shaped module ("social media presence") isn't an entity collection.
    it "returns [] when the only carousel-shaped module is not an entity collection (Unilever)" do
      html = File.read("#{FIXTURES}/unilever_brands.html")
      expect(described_class.call(html)).to eql([])
    end
  end

  describe "per-tile guards" do
    it "drops anchors that lack an image or an href, keeping only real tiles" do
      html = <<~HTML
        <div data-attrid="kc:/music/artist:albums">
          <a href="/search?q=Real+Album">
            <img alt="Real Album" src="data:image/jpeg;base64,AAAA"><div>Real Album</div>
          </a>
          <a href="/search?q=More+results">More results</a>
          <a><img alt="No href" src="data:image/jpeg;base64,BBBB"></a>
        </div>
      HTML

      expect(described_class.call(html).map { |e| e[:name] })
        .to eql(["Real Album"])
    end

    it "skips the data:image/gif placeholder in favor of the in-page data-src url" do
      html = <<~HTML
        <div data-attrid="kc:/music/artist:albums">
          <a href="/search?q=Lazy+Tile">
            <img alt="Lazy Tile"
                 src="data:image/gif;base64,R0lGODlhAQABAAAAACw="
                 data-src="https://encrypted-tbn0.gstatic.com/images?q=tbn:lazy">
            <div>Lazy Tile</div>
          </a>
        </div>
      HTML

      entry = described_class.call(html).first
      expect(entry[:image])
        .to eql("https://encrypted-tbn0.gstatic.com/images?q=tbn:lazy")
    end

    it "handles an img with no src attribute, falling back to data-src" do
      html = <<~HTML
        <div data-attrid="kc:/music/artist:albums">
          <a href="/search?q=Srcless+Tile">
            <img alt="Srcless Tile" data-src="https://encrypted-tbn0.gstatic.com/images?q=tbn:srcless">
            <div>Srcless Tile</div>
          </a>
        </div>
      HTML

      entry = described_class.call(html).first
      expect(entry[:image])
        .to eql("https://encrypted-tbn0.gstatic.com/images?q=tbn:srcless")
    end
  end
end
