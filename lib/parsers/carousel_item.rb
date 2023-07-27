module Parsers
  class CarouselItem

    attr_reader :item

    def initialize(item)
      @item = item
    end

    def name
      @name ||= item.attr('aria-label')
    end

    def link
      @link ||= (google_base_url + item.attr('href'))
    end

    def extensions
      @extensions ||= prepare_extensions
    end

    private

    def google_base_url
      Constants::Google.base_url
    end

    def prepare_extensions
      item.css('div > ::text').map(&:content)
    end
  end
end
