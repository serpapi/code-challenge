# frozen_string_literal: true

module Scrapers
  class GoogleCarousel20230813 < GoogleCarousel
    private

    def single_box_class
      parsed.css('g-scrolling-carousel a').first['class']
    end

    def heading
      parsed.css('g-scrolling-carousel').first.previous_element.css('span').last.text.downcase
    end

    def link_element
      @link_element ||= current_element
    end
  end
end
