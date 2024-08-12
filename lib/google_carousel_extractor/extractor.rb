# frozen_string_literal: true

require_relative 'carousel_parser'
require_relative 'carousel_item_builder'

module GoogleCarouselExtractor
  class Extractor
    attr_reader :parser

    def self.extract(html_file = 'files/van-gogh-paintings.html')
      new(html_file).extract
    end

    def initialize(html_file)
      @parser = CarouselParser.new(html_file)
    end

    def extract
      parser.items.map do |item|
        CarouselItemBuilder.new(item).build
      end
    end
  end
end
