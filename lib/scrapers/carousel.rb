module Scrapers
  module Carousel
    def scrape_carousel
      anchors.map do |node|
        {
          name: nil,
          extensions: nil,
          link: nil,
          image: nil
        }
      end
    end

    def carousel
      @_carousel ||= @document.search("g-scrolling-carousel").first
    end

    def anchors
      @_anchors ||= carousel.search("a")
    end
  end
end
