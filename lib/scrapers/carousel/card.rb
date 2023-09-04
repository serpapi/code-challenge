module Scrapers
  module Carousel
    class Card
      def initialize(node)
        @node = node
      end

      def to_hash
        {
          name: name,
          extensions: extensions,
          link: link,
          image: image
        }
      end

      def name
      end

      def extensions
      end

      def link
      end

      def image
      end
    end
  end
end
