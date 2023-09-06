require "nokogiri"
require "./app/google/carousel_item_parser"

module Google
  class CarouselParser
    def initialize(serp_string)
      @serp_string = serp_string
    end

    def items
      items_html.map do |item_html|
        Google::CarouselItemParser.new(
          item_html: item_html,
          images_by_id: images_by_id
        ).to_h
      end
    end

    # Image data is stored in a JS function that sets the image source for each
    #  item in the carousel. This method extracts the image data and stores it
    #  in a hash, where the key is the image id and the value is the image data
    #
    # Regex:
    # 1. Capture the value of the "s" variable
    # 2. Capture the value of the "ii" variable
    # expected format: var s = 'IMAGE_DATA'; var ii = ['IMAGE_ID'];
    def images_by_id
      @images_by_id ||= begin
        matches = serp_string.scan(/var s\s*=\s*'(.*?)';\s*var ii\s*=\s*\['(.*?)'\];/)

        matches.each_with_object({}) do |match, map|
          image, id = match
          map[id] = image.gsub("\\x", "x")
        end
      end
    end

    private

    attr_reader :serp_string

    def serp_html
      @serp_html ||= Nokogiri::HTML(serp_string)
    end

    def items_html
      serp_html.search(
        "g-scrolling-carousel a.klitem, g-scrolling-carousel a.klitem-tr"
      )
    end
  end
end
