# frozen_string_literal: true

module GoogleCarouselExtractor
  class CarouselItemBuilder
    attr_reader :a_tag

    def initialize(a_tag)
      @a_tag = a_tag
    end

    def build
      carousel_item = {
        name: extract_title,
        link: build_link,
        image: extract_image_src
      }

      carousel_item[:extensions] = [extract_date] if extract_date
      carousel_item
    end

    private

    def extract_title
      a_tag.attribute_nodes.find { |attr| attr.name == 'aria-label' }&.value
    end

    def build_link
      href = a_tag.attribute_nodes.find { |attr| attr.name == 'href' }.value
      "https://www.google.com#{href}"
    end

    def extract_date
      a_tag.at_css('.ellip')&.text&.strip
    end

    def extract_image_src
      a_tag.at_css('img')&.attr('src')
    end
  end
end
