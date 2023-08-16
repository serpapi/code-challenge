# frozen_string_literal: true

require 'services/abstract_service'
require 'nokogiri'
require 'uri'

module Services
  # parse google search carousel
  class CarouselParser < AbstractService
    URL = 'https://www.google.com'

    def initialize(html)
      super()
      @html = html
    end

    def call
      parser = ::Nokogiri::HTML(@html)

      # get carousel items
      parent_nodes = parser.css('g-scrolling-carousel')[0].css('a')
      # map carousel items to our special flavour artwork array :)
      build_items_by_parent_nodes(parent_nodes)
    end

    private

    def build_items_by_parent_nodes(parent_nodes)
      parent_nodes.map do |node|
        name = build_name(node)
        year = node.css('.klmeta')[0]&.text
        link = build_link(node)
        image = build_image(node)
        build_carousel_item(name, year, link, image)
      end
    end

    def build_carousel_item(name, year, link, image)
      item = {
        'name' => name,
        'image' => image,
        'link' => link
      }
      item['extensions'] = [year] if year
      item
    end

    def build_link(node)
      link = node&.attributes&.[]('href')&.value
      return unless link

      link = [URL, link].join unless link.start_with? URL
      link
    end

    def build_name(node)
      node.attributes['aria-label'].value
    end

    def build_image(node)
      node.css('g-img img')[0]&.attributes&.[]('src')&.value
    end
  end
end
