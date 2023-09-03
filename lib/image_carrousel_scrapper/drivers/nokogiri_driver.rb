# frozen_string_literal: true

require 'nokogiri'
require_relative 'base_driver'

class ImageCarrouselScrapper
  module Drivers
    class NokogiriDriver < BaseDriver
      def carrousel_list
        carrousel_items.map do |item|
          name = item.attributes['aria-label']&.value
          next unless name

          RESULT.new(
            name: item.attribute('aria-label')&.value,
            image: image_src(item),
            link: google_link(item.attribute('href')&.value)
          ).tap do |result|
            extensions = item.css('.ellip').map(&:text)
            result.extensions = extensions unless extensions.empty?
          end
        end.compact
      end

      private

      def image_src(node)
        id = node.css('img:first-child').attribute('id').value

        base64_blobs[id]
      end

      def base64_blobs
        @base64_blobs ||= base64_images_list.each_with_object({}) do |item, buff|
          buff[item[1]] = item[0].delete('\\')
        end
      end

      def base64_images_list
        parser.inner_html.scan(/setImagesSrc.+?var\ s='(.*?)'.*?var\ ii=\['(\w+)'\]/)
      end

      def google_link(path)
        "https://www.google.com#{path}"
      end

      def carrousel_items
        parser.xpath('//g-scrolling-carousel//div//a')
      end

      def parser
        @parser ||= Nokogiri::HTML(file.read)
      end
    end
  end
end
