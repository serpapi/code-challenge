require "nokogiri"
require "./app/google/carousel_item_parser"

RSpec.describe Google::CarouselItemParser do
  context "March 2019 Layout" do
    before(:all) do
      @starry_night_parser = setup_parser(file_path: "./files/starry-night.html")
      @sunflowers_parser = setup_parser(file_path: "./files/sunflowers.html")
    end

    describe "#name" do
      it "returns the name of the item" do
        expect(@starry_night_parser.name).to eq("The Starry Night")
      end
    end

    describe "#extensions" do
      it "returns an array of dates" do
        expect(@starry_night_parser.extensions).to eq(["1889"])
      end

      it "returns nil if no dates are found" do
        expect(@sunflowers_parser.extensions).to eq(nil)
      end
    end

    describe "#link" do
      it "returns the Google search link to the item" do
        expect(@starry_night_parser.link).to eq("https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw")
      end
    end

    describe "#image" do
      it "returns the image data" do
        expect(@starry_night_parser.image).to eq("IMAGE_DATA")
      end
    end

    describe "#to_h" do
      it "returns a hash of the item" do
        expect(@starry_night_parser.to_h).to eq({
          name: "The Starry Night",
          extensions: ["1889"],
          link: "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
          image: "IMAGE_DATA"
        })
      end

      it "excludes the extensions key if there are no extensions" do
        expect(@sunflowers_parser.to_h.keys).to_not include(:extensions)
      end

      it "includes the image key even if there is no image" do
        expect(@sunflowers_parser.to_h.keys).to include(:image)
      end
    end
  end

  context "August 2023 Layout" do
    before(:all) do
      @starfield_parser = setup_parser(file_path: "./files/starfield.html")
    end

    describe "#name" do
      it "returns the name of the item" do
        expect(@starfield_parser.name).to eq("Starfield")
      end
    end

    describe "#extensions" do
      it "returns an array of dates" do
        expect(@starfield_parser.extensions).to eq(["2023"])
      end
    end

    describe "#link" do
      it "returns the Google search link to the item" do
        expect(@starfield_parser.link).to eq("https://www.google.com/search?sca_esv=561640084&q=Starfield&stick=H4sIAAAAAAAAAONgFuLVT9c3NEzLKchKqcw1VYJwM4yT0gviLZK0FLKTrfSTy9JBOL4gJ7EkLb8o16osMyU1XyE9MTe1-BFjGLfAyx_3hKV8J605eY3RnYugFiFpLjbXvJLMkkohQSl-LlQHWDFpMFUxcTDyLGLlDC5JLErLTM1JmcDGCACUsxCKqgAAAA&sa=X&ved=2ahUKEwiZ1IK4p4eBAxVpjokEHcshCswQ-BZ6BAgdEA4&tbs=kac:1,kac_so:0")
      end
    end

    describe "#image" do
      it "returns the data-src of the image when img tag has no id" do
        ac_parser = setup_parser(file_path: "./files/assassins-creed.html")

        expect(ac_parser.image).to eq("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4cCRJrS9EuwcKaDKMePQr6Y-MRjQZyDE6-NpCYNynJho5EbgOVqRu&s=0")
      end
    end

    describe "#to_h" do
      it "returns a hash of the item" do
        parser = setup_parser(file_path: "./files/starfield.html")

        expect(parser.to_h).to eq({
          name: "Starfield",
          extensions: ["2023"],
          link: "https://www.google.com/search?sca_esv=561640084&q=Starfield&stick=H4sIAAAAAAAAAONgFuLVT9c3NEzLKchKqcw1VYJwM4yT0gviLZK0FLKTrfSTy9JBOL4gJ7EkLb8o16osMyU1XyE9MTe1-BFjGLfAyx_3hKV8J605eY3RnYugFiFpLjbXvJLMkkohQSl-LlQHWDFpMFUxcTDyLGLlDC5JLErLTM1JmcDGCACUsxCKqgAAAA&sa=X&ved=2ahUKEwiZ1IK4p4eBAxVpjokEHcshCswQ-BZ6BAgdEA4&tbs=kac:1,kac_so:0",
          image: nil
        })
      end
    end
  end

  def setup_parser(file_path:)
    html_string = File.read(file_path)
    html = Nokogiri::HTML::DocumentFragment
      .parse(html_string)
      .children
      .first

    Google::CarouselItemParser.new(
      item_html: html,
      images_by_id: {"kximg0" => "IMAGE_DATA"}
    )
  end
end
