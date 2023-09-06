require "json"
require "./app/google/carousel_parser"

RSpec.describe Google::CarouselParser do
  context "March 2019 Layout" do
    before(:all) do
      van_gogh_html = File.read("./files/van-gogh-paintings.html")
      @parser = Google::CarouselParser.new(van_gogh_html)
    end

    describe "#items" do
      it "extracts the carousel items" do
        expected_array = JSON.parse(
          File.read("./files/expected-array.json"), symbolize_names: true
        )

        @parser.items.each_with_index do |artwork, i|
          expect(artwork).to eq(expected_array[i])
        end
      end
    end

    describe "#images_by_id" do
      it "returns a hash of images by item id" do
        expected_hash = JSON.parse(File.read("./files/expected-images-hash.json"))

        expect(@parser.images_by_id).to eq(expected_hash)
      end

      it "extract the image data and id from the html" do
        @parser = Google::CarouselParser.new(example_image_string)

        expect(@parser.images_by_id).to eq({"IMAGE_ID" => "IMAGE_DATA"})
      end

      it "replaces the \\x with x in the image data" do
        @parser = Google::CarouselParser.new(example_image_string(image_data: "\\x"))

        expect(@parser.images_by_id).to eq({"IMAGE_ID" => "x"})
      end
    end
  end

  context "August 2023 Layout" do
    before(:all) do
      games_html = File.read("./files/xbox-games.html")
      @parser = Google::CarouselParser.new(games_html)
    end

    describe "#items" do
      it "extracts the correct number of items" do
        expect(@parser.items.count).to eq(51)
      end

      it "returns a hash representation of the item" do
        expect(@parser.items.first).to eq({
          name: "Starfield",
          extensions: ["2023"],
          link: "https://www.google.com/search?sca_esv=561640084&q=Starfield&stick=H4sIAAAAAAAAAONgFuLVT9c3NEzLKchKqcw1VYJwM4yT0gviLZK0FLKTrfSTy9JBOL4gJ7EkLb8o16osMyU1XyE9MTe1-BFjGLfAyx_3hKV8J605eY3RnYugFiFpLjbXvJLMkkohQSl-LlQHWDFpMFUxcTDyLGLlDC5JLErLTM1JmcDGCACUsxCKqgAAAA&sa=X&ved=2ahUKEwiZ1IK4p4eBAxVpjokEHcshCswQ-BZ6BAgdEA4&tbs=kac:1,kac_so:0",
          image: "data:image/png;base64,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"
        })
      end
    end
  end

  def example_image_string(image_data: "IMAGE_DATA")
    <<~TEXT
      (function () {
        var s = '#{image_data}';
        var ii = ['IMAGE_ID']; _setImagesSrc(ii, s);
      })();
    TEXT
  end
end
