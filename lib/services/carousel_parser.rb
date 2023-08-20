# frozen_string_literal: true

require_relative 'abstract_service'
require 'nokogiri'
require 'uri'

module Services
  # parse google search carousel
  class CarouselParser < AbstractService
    URL = 'https://www.google.com'
    CAROUSEL_TAG = 'g-scrolling-carousel'
    IMAGE_TAG = 'g-img img'
    META_TAG = '.klmeta'
    NAME_LABEL = 'aria-label'

    def initialize(html)
      super()
      @html = html
    end

    def call
      parser = ::Nokogiri::HTML(@html)

      # get carousel items
      parent_nodes = parser.css(CAROUSEL_TAG)[0]&.css('a') || []
      # map carousel items to our special flavour artwork array :)
      build_items_by_parent_nodes(parent_nodes)
    end

    private

    def build_items_by_parent_nodes(parent_nodes)
      parent_nodes.map do |node|
        params = %i[name meta link image].map(&(proc { |item| send("build_#{item}", node) }))
        build_carousel_item(*params)
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
      link = node.attributes&.[]('href')&.value
      return unless link

      link = [URL, link].join unless link.start_with? URL
      link
    end

    def build_name(node)
      node.attributes[NAME_LABEL].value
    end

    def build_image(node)
      node.css(IMAGE_TAG)[0]&.attributes&.[]('src')&.value
    end

    def build_meta(node)
      node.css(META_TAG)[0]&.text
    end
  end
end
