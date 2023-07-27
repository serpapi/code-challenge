require 'google_carousel/constants/google'
require 'google_carousel/parsers/carousel'
require 'google_carousel/parsers/carousel_item'
require 'google_carousel/extract/carousel_image'

module GoogleCarousel
  class << self

    def parse(raw_html)
      GoogleCarousel::Parsers::Carousel.new(raw_html).parse
    end
  end
end
