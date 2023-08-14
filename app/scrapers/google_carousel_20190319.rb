# frozen_string_literal: true

module Scrapers
  # Carousel scraper adjusted to the original challenge file
  # Named after the commit date of that file
  class GoogleCarousel20190319 < GoogleCarousel
    private

    def single_box_class
      parsed.css('g-scrolling-carousel a').first.parent['class']
    end

    def heading
      parsed.css('#extabar span span')[2].css('span')[1].inner_html.downcase
    end

    def link_element
      @link_element ||= current_element.css('a').first
    end
  end
end
