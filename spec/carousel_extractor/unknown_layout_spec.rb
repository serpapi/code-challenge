require "spec_helper"
require "carousel_extractor"

RSpec.describe CarouselExtractor do
  describe "unknown layout" do
    it "raises UnknownLayoutError when no recognized layout is found" do
      expect { described_class.new("<html></html>").extract }
        .to raise_error(CarouselExtractor::UnknownLayoutError)
    end
  end
end
