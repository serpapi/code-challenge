require 'uri'

module Parsers
  class CarouselItem
    def initialize(carousel_item_html)
      @carousel_item_html = carousel_item_html
    end

    def data
      {
        name:       name,
        extensions: extensions,
        link:       link,
        image:      image
      }
    end

    def name
      carousel_item_html['aria-label']
    end

    def extensions
      [carousel_item_html.css('.klmeta').first&.text].compact
    end

    def link
      URI.join('https://www.google.com', carousel_item_html['href']).to_s
    end

    def image
      carousel_item_html.css('g-img > img').first['src']
    end

    private

    attr_reader :carousel_item_html
  end
end
