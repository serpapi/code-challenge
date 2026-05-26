require "nokolexbor"
require "carousel_item"
require "image_extractor"
require "layouts"

# Parses a Google SERP HTML page and extracts all carousel items.
class CarouselExtractor
  class UnknownLayoutError < StandardError; end

  def initialize(html)
    @doc = Nokolexbor::HTML(html)
  end

  def extract
    layout = Layouts.detect(@doc)
    raise UnknownLayoutError, "no recognized carousel layout found — add a new Layouts:: adapter" unless layout

    images = ImageExtractor.new(@doc)
    @doc.css(layout.item_selector).filter_map do |node|
      item = CarouselItem.new(node, images, layout).to_h
      item if item[:name] || item[:link]
    end
  end
end
