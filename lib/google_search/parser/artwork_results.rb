# frozen_string_literal: true

require 'nokogiri'

module GoogleSearch
  module Parser
    class ArtworkResults
      def initialize(io)
        @doc = Nokogiri::HTML(io)
      end

      def results
        artworks = @doc.xpath('//a[@class="klitem"]').map do |item|
          build_artwork_item(item)
        end

        { artworks: }
      end

      private

      def build_artwork_item(item)
        item_id = item.at_css('g-img > img')['id']

        {
          name: item['aria-label'],
          extensions: build_extensions(item),
          link: "https://www.google.com#{item['href']}",
          image: thumbnails[item_id]
        }
      end

      def thumbnails
        @thumbnails ||= prase_embedded_artwork_thumbnails.merge(parse_remote_artwork_thumbnails)
      end

      def prase_embedded_artwork_thumbnails
        regex = %r{
          var\s?(?:^[^a-zA-Z_$]|\w+)\s?=\s?'(data:image/[^;]+;base64[^']+)';
          \s?
          var\s?(?:^[^a-zA-Z_$]|\w+)\s?=\s?\['([a-z0-9_]+)'\];
        }x

        @doc.content.scan(regex).each_with_object({}) { |(url, id), h| h[id] = unescape_hex(url) }
      end

      def parse_remote_artwork_thumbnails
        @doc.xpath('//img[@data-src]').to_h do |img_tag|
          [img_tag['id'], img_tag['data-src']]
        end
      end

      def unescape_hex(str)
        str.gsub(/\\x\h{2}/) { |m| m[2, 2].hex.chr }
      end

      def build_extensions(item)
        extensions = item.css('div.klmeta').map(&:content)
        return nil unless extensions.any?

        extensions
      end
    end
  end
end
