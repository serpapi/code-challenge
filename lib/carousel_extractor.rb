require "nokolexbor"
require "carousel_item"
require "image_extractor"
require "layouts/i_elo6"
require "layouts/j_cuz_jd"
require "layouts/z8r5_gb"

# Parses a Google SERP HTML page and extracts all carousel items.
class CarouselExtractor
  class UnknownLayoutError < StandardError; end

  LAYOUTS = [Layouts::IELo6.new, Layouts::JCuzJd.new, Layouts::Z8r5Gb.new].freeze

  def initialize(html)
    @doc = Nokolexbor::HTML(html)
  end

  def extract
    layout = LAYOUTS.find { |l| @doc.css(l.item_selector).any? }
    raise UnknownLayoutError, "no recognized carousel layout found — add a new Layouts:: adapter" unless layout

    images = ImageExtractor.new(@doc)
    @doc.css(layout.item_selector).filter_map do |node|
      item = CarouselItem.new(node, images, layout).to_h
      item if item[:name] || item[:link]
    end
  end
end
