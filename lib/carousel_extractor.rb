require "nokolexbor"
require "carousel_item"
require "image_extractor"

# Parses a Google SERP HTML page and extracts all carousel items.
class CarouselExtractor
  def initialize(html)
    @doc = Nokolexbor::HTML(html)
  end

  def extract
    images = ImageExtractor.new(@doc)
    @doc.css(".iELo6").map { |node| CarouselItem.new(node, images).to_h }
  end
end
