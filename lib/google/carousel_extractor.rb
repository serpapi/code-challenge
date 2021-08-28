# frozen_string_literal: true

module Google
  # Extractor specifically for Google Carousel Search
  class CarouselExtractor
    def initialize(search)
      @search = search
    end

    def extract
      @search.map do |node|
        data(node)
      end
    end

    private

    def data(data)
      {
        name: name(data),
        extensions: [date(data)],
        link: link(data),
        image: image(data)
      }
    end

    def link(data)
      "https://www.google.com#{data.attributes['href']&.value}"
    end

    def image(data)
      data.at_css('g-img img').attributes['data-key']&.value
    end

    def name(data)
      name_node = data.css('.kltat span')

      return name_node.first.text + name_node.last.text if name_node.count > 1

      name_node.first.text
    end

    def date(data)
      data.at_css('.ellip.klmeta')&.text
    end
  end
end
