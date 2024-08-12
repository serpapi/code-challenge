# frozen_string_literal: true

require 'nokogiri'

module GoogleCarouselExtractor
  class CarouselParser
    attr_reader :doc

    def initialize(html_file)
      @doc = Nokogiri::HTML(File.read(html_file))
    end

    def items
      google_carousel&.css('a') || []
    end

    private

    def google_carousel
      doc.css('g-scrolling-carousel').first
    end
  end
end
