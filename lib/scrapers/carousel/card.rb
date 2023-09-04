module Scrapers
  module Carousel
    class Card
      def initialize(node)
        @node = node
      end

      def to_hash
        {
          name: nil,
          extensions: nil,
          link: nil,
          image: nil
        }
      end
    end
  end
end
