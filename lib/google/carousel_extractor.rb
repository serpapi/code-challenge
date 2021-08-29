# frozen_string_literal: true

module Google
  # Extractor specifically for Google Carousel Search
  class CarouselExtractor
    def initialize(search)
      @search = search
    end

    def extract
      { artworks: @search.map { |node| data(node) } }
    end

    private

    def data(data)
      {
        name: data.css('.kltat span').map(&:text).join(''),
        extensions: data.css('.ellip.klmeta').map(&:text),
        link: "https://www.google.com#{data.attributes['href']&.value}",
        image: data.at_css('g-img img').attributes['data-key']&.value
      }
    end
  end
end
