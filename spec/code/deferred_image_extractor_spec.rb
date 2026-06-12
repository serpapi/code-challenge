# frozen_string_literal: true

require "nokolexbor"
require "json"

RSpec.describe Code::Challenge::DeferredImageExtractor do
  describe ".extract" do
    it "extracts deferred base64 image mappings from script-backed fixture" do
      html = File.read(File.expand_path("../fixtures/carousel_script_base64.html", __dir__))
      expected = JSON.load_file(File.expand_path("../fixtures/carousel_script_base64.json", __dir__))
      document = Nokolexbor::HTML(html)

      mappings = described_class.extract(document)
      image_id = document.at_css("img[id]")["id"]

      expect(mappings[image_id]).to eq(expected.first["image"])
    end

    it "extracts multiple mappings from multiple _setImagesSrc calls in one script" do
      html = File.read(File.expand_path("../fixtures/carousel_multi_mapping_script.html", __dir__))
      document = Nokolexbor::HTML(html)

      expect(described_class.extract(document)).to eq(
        {
          "ext_img_1" => "data:image/jpeg;base64,AAA111=",
          "ext_img_2" => "data:image/jpeg;base64,BBB222="
        }
      )
    end

    it "raises when ids are found but no data URI resolves for that call" do
      malformed_html = <<~HTML
        <!doctype html>
        <html>
          <body>
            <script>
              (function(){
                var ids=['img_1'];
                var blank='';
                var payload='data:image/jpeg;base64,ABC123\\x3d';
                _setImagesSrc(ids, blank, blank);
              })();
            </script>
            <img id="img_1" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==">
          </body>
        </html>
      HTML

      document = Nokolexbor::HTML(malformed_html)

      expect { described_class.extract(document) }
        .to raise_error(Code::Challenge::StructuralMismatchException, /deferred data URI/)
    end
  end
end
