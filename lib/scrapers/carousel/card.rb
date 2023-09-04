module Scrapers
  module Carousel
    class Card
      GOOGLE_BASE_URL = "https://www.google.com"

      def initialize(node, document)
        @node = node
        @document = document
      end

      def to_hash
        hash = {}
        hash[:name] = name
        hash[:extensions] = extensions if extensions.any?
        hash[:link] = GOOGLE_BASE_URL + path
        hash[:image] = image_url
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
        img_id = @node.search("img").first.attribute("id").value

        split_text = @document.text.split(img_id)[0].gsub("';var ii=['", "")
        result = split_text.split("var s='").last.delete("\\")

        return if result.include?(" ")
        result
      rescue
        nil
      end
    end
  end
end
