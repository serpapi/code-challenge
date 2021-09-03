module Parsers
  class Carousel
    CAROUSEL_ITEM_SELECTOR = ["a[role='button']", "a[role='listitem']"].freeze

    def initialize(carousel_html)
      @carousel_html = carousel_html
    end

    def data
      items.map(&:data)
    end

    private

    attr_reader :carousel_html

    def items
      carousel_html.css(*CAROUSEL_ITEM_SELECTOR).map(&Parsers::CarouselItem.method(:new))
    end
  end
end
