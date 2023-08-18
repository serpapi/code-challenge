# frozen_string_literal: true

require_relative "search_result_parser"

# nodoc
module Google
  # A parser for the base version of the carousel
  class CarouselV1 < SearchResultParser
    def items
      @items ||=
        doc
        .css("g-scrolling-carousel")
        .css("a.klitem")
        .zip(images)
        .map { CarouselV1Item.new(_1, image: _2) }
    end

    def images
      @images ||=
        doc
        .css("script")
        .find { _1.text.match?(/_setImagesSrc/) }
        &.text
        &.scan(/var s='(.+?)'/)
        &.flatten
        .to_a
    end

    def parseable?
      doc.css(".klitem").any?
    end
  end

  # A wrapper for a single carousel item
  class CarouselV1Item
    attr_accessor :node, :image

    def initialize(node, image: nil)
      self.node = node
      self.image = image
    end

    def name
      node.attr("aria-label")
    end

    def extensions
      node.css(".klmeta").children.map(&:text)
    end

    def link
      [BASE_URL, node.attr("href")].join
    end
  end
end
