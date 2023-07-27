module GoogleCarousel
  module Parsers
    class CarouselItem

      attr_reader :item

      def initialize(item)
        @item = item
      end

      def name
        @name ||= item.attr('aria-label')
      end

      def link
        @link ||= (google_base_url + item.attr('href'))
      end

      def extensions
        @extensions ||= prepare_extensions
      end

      def img_id
        @img_id ||= image_tag.attr('id')
      end

      private

      def google_base_url
        GoogleCarousel::Constants::Google.base_url
      end

      def prepare_extensions
        item.css('div > ::text').map(&:content)
      end

      def img_sources
        GoogleCarousel::Extract::CarouselImage.new()
      end

      def image_tag
        @image_tag ||= item.css('img').first
      end
    end
  end
end
