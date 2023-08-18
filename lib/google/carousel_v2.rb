# frozen_string_literal: true

require_relative "search_result_parser"

# nodoc
module Google
  # A parser for the updated version of the carousel
  class CarouselV2 < SearchResultParser
    def items
      @items ||=
        doc
        .css("g-scrolling-carousel")
        .css("a.ttwCMe")
        .map { CarouselV2Item.new(_1) }
    end

    def parseable?
      doc.css("g-scrolling-carousel a.ttwCMe").any?
    end
  end

  # A wrapper for a single carousel item
  class CarouselV2Item
    attr_accessor :node, :extensions, :image

    def initialize(node)
      self.node = node
    end

    def name
      node.attr("title")
    end

    def link
      [BASE_URL, node.attr("href")].join
    end
  end
end
