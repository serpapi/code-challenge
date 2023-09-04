module Scrapers
  module Carousel
    class Card
      def initialize(node)
        @node = node
      end

      def to_hash
        hash = {}
        hash[:name] = name
        hash[:extensions] = extensions if extensions.any?
        hash[:link] = nil
        hash[:image] = nil
        hash
      end

      def name
        @_name ||= @node.attribute("aria-label").value
      end

      def extensions
        @_extensions ||= @node.text.gsub(name, "")&.strip&.split(",")
      end

      def link
      end

      def image_url
      end
    end
  end
end
