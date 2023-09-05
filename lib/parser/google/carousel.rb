require 'nokogiri'

module Parser
  module Google
    class Carousel < ApplicationParser

      HTML_STRUCTURE ||= {
        container: '.klcc',
        item: '.klitem',
        title: '.kltat',
        year: '.klmeta',
        image: '.klic g-img img'
      }.freeze

      # <div class='klcc'>
      # 	> g-scrolling-carousel > div > div > div
      # 		<div class='klitem'>
      # 			> div
      # 				<div class='klic'>
      # 					> g-img
      # 						<img />
      # 				</div>

      # 			> div
      # 				<div class='kltat'></div>
      # 				<div class='klmeta'></div>
      # 		</div>
      # </div>

      # > indicates that the div is a direct child of another div, or some HTML element.

      def call
        image_id_to_base64 = build_image_id_to_base64_map

        doc.css(HTML_STRUCTURE[:item]).map do |item|
          build_result(item, image_id_to_base64)
        end
      end

      def build_result(item, image_id_to_base64)
        name = item.css(HTML_STRUCTURE[:title])&.text&.strip.gsub(/\s+/, ' ')
        year = item.css(HTML_STRUCTURE[:year])&.text&.strip
        image = item.css(HTML_STRUCTURE[:image])
        link = item.attr('href')

        {
          name: name,
          extensions: [year],
          link: link,
          image: image_id_to_base64[image.attr('id').value]
        }
      end

      private

      def file = @file ||= read_file
      def doc = @doc ||= parse_file

      def read_file
        File.read('files/van-gogh-paintings.html')
      rescue Errno::ENOENT
        raise "File not found at path: #{'lib/van-gogh-paintings.html'}"
      end

      def parse_file
        Nokogiri::HTML(file)
      rescue Nokogiri::SyntaxError
        raise "Invalid HTML file at path: #{'lib/van-gogh-paintings.html'}"
      end

      def build_image_id_to_base64_map
        doc = Nokogiri::HTML(file)

        doc.xpath("//script[contains(., '_setImagesSrc')]").text.split('(function()').each_with_object({}) do |node, images|
          next unless node.include?('data:image/jpeg')

          id = node.match(/var ii=\['(.*)'\]/)&.captures&.first

          # The String is a Base64 safe encoded value, and the padding comes as '\x3d' instead of '='.
          # We need to replace it if we want to get the actual Base64 value.
          #
          image_base64 = node.match(/s='(.*)';var ii/)&.captures&.first&.gsub(/\\x3d/, '=')

          images[id] = image_base64
        end
      end
    end
  end
end