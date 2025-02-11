require "parse_utils"

describe ParseUtils do
  describe "#parse_image_group" do
    it "parses already visible image" do
      html = Nokogiri::HTML.parse(<<~HTML)
        <div class="iELo6" style="width:153px;top:8px;left:8px" jsdata="JI96Wc;unsupported;BCVKE8">
          <a
            href="/search?sca_esv=31337&amp;hl=en">
            <img class="taFZJe" alt="Some Title" id="i_love_complicated_ids"
              src="data:image/gif;base64,lovely-placeholder"
              data-deferred="1">
            <div class="KHK6lb">
              <div class="pgNMRc">Some Title</div>
              <div class="cxzHyb">1337</div>
            </div>
          </a>
        </div>
      HTML

      expect(ParseUtils.parse_image_group(html, nil)).to eq [{
        extensions: ["1337"],
        id: "i_love_complicated_ids",
        image_src: nil,
        link: "/search?sca_esv=31337&hl=en",
        name: "Some Title"}
      ]
    end

    it "parses hidden image" do
      html = Nokogiri::HTML.parse(<<~HTML)
        <div class="iELo6" style="display:none;width:0px;top:0px;left:0px"
          jsdata="JI96Wc;unsupported;ARLn1s">
          <a
            href="/search?sca_esv=31337&amp;hl=en">
            <img class="taFZJe" alt="Some Title"
              data-src="some-real-image-url"
              src="data:image/gif;base64,lovely-placeholder"
              data-csiid="i_love_complicated_ids" data-atf="0">
            <div class="KHK6lb">
              <div class="pgNMRc">Some Title</div>
              <div class="cxzHyb"></div>
            </div>
          </a>
        </div>
      HTML

      expect(ParseUtils.parse_image_group(html, nil)).to eq [{
        extensions: [],
        id: nil,
        image_src: "some-real-image-url",
        link: "/search?sca_esv=31337&hl=en",
        name: "Some Title"}
      ]
    end
  end

  describe "#parse_script_images" do
    it "properly escapes images" do
      html = Nokogiri::HTML.parse(<<~HTML)
        <script nonce="incorrect_id">(function(){var s='data:image/jpeg;base64,img_with_padding\x3d\x3d';var ii=['correct_complicated_id'];var r='';_setImagesSrc(ii,s,r);})();</script>
      HTML

      expect(ParseUtils.parse_script_images(html)).to match a_hash_including({
        a_string_including("correct_complicated_id") => "data:image/jpeg;base64,img_with_padding=="
      })
    end
  end

  describe "#parse_file" do
    it "parses fixture as expected" do
      want = JSON.load_file!("./files/expected-array.json")
      have = ParseUtils.parse_file("./files/van-gogh-paintings.html")

      expect(have).to eq want
    end

    it "doesn't raise on invalid input" do
      expect(ParseUtils.parse_file("./files/van-gogh-paintings.png")).to eq({})
    end
  end
end
