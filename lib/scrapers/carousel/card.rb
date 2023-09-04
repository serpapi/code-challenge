module Scrapers
  module Carousel
    class Card
      GOOGLE_BASE_URL = "https://www.google.com"

      def initialize(node)
        @node = node
      end

      def to_hash
        hash = {}
        hash[:name] = name
        hash[:extensions] = extensions if extensions.any?
        hash[:link] = GOOGLE_BASE_URL + path
        hash[:image] = nil
        hash
      end

      def name
        @_name ||= @node.attribute("aria-label").value
      end

      def extensions
        @_extensions ||= @node.text.gsub(name, "")&.strip&.split(",")
      end

      def path
        @_link ||= @node.attribute("href")&.value
      end

      def image_url
      end
    end
  end
end
