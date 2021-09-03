require_relative './base.rb'

module Parsers
  class Carousel < Parsers::Base
    def data
      items.map { |item| Parsers::CarouselItem.new(item, version).data }
    end

    def items
      extract_value(:items)
    end
  end
end
