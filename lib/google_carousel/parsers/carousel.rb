require 'nokolexbor'

module GoogleCarousel
  module Parsers
    class Carousel

      attr_reader :raw_html, :doc

      def initialize(raw_html)
        @raw_html = raw_html
      end

      def parse
        @doc = Nokolexbor::HTML(raw_html.encode('utf-8'))

        carousel_items = []
        doc.at_css('g-scrolling-carousel').traverse do |x|
          if (x.name == 'a')
            carousel_items << GoogleCarousel::Parsers::CarouselItem.new(x)
          end
        end

        result = { "artworks" => [] }
        carousel_items.each do |item|
          img_id = item.img_id

          result["artworks"] << {
            "name" => item.name,
            "link" => item.link,
            "extensions" => item.extensions,
            "image" => carousel_images.fetch(img_id, '')
          }
        end

        result
      end

      def carousel_images
        @carousel_images ||= GoogleCarousel::Extract::CarouselImage.new(doc).fetch_images
      end
    end
  end
end
