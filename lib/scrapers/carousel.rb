require_relative "./carousel/card"

module Scrapers
  module Carousel
    def scrape_carousel
      raise "No Carousel found in the HTML document." unless carousel

      anchors.map { |node| Card.new(node, @document).to_hash }
    end

    def carousel
      @_carousel ||= @document.search("g-scrolling-carousel").first
    end

    def anchors
      @_anchors ||= carousel.search("a")
    end
  end
end
