require 'nokogiri'

module Parser
  module Google
    class Carousel < ApplicationParser

      SRUCTURE ||= {
        container: '.klcc',
        item:			 '.klitem',
        title:		 '.kltat',
        year:			 '.klmeta',
        image:		 '.klic g-img img' # .M4dUYb - This could also work, but without more context, and the fact that the source is static and the class looking like a randomly generated one, I'm not sure if it's reliable.
      }

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
        doc = Nokogiri::HTML(file)
        images_array = doc.xpath("//script[contains(., '_setImagesSrc')]").text.split('(function()').each_with_object({}) do |node, images|
          begin
            id = node.match(/var ii=\['(.*)'\]/)&.captures&.first

            # The String is a Base64 safe encoded value, and the padding comes as '\x3d' instead of '='.
            # We need to replace it if we want to get the actual Base64 value.
            #
            image_base64 = node.match(/s='(.*)';var ii/)&.captures&.first&.gsub(/\\x3d/, '=')

            images[id] = image_base64
          rescue

          end
        end

        [].tap do |data|
          doc.css(SRUCTURE[:item]).each_with_object({}) do |item, object|

            title	 = item.css(SRUCTURE[:title])&.text&.strip.gsub(/\s+/, ' ')
            year	 = item.css(SRUCTURE[:year])&.text&.strip

            # NOTE: The initial image is a placeholder. The actual image is loaded via JS.
            #
            image	 = item.css(SRUCTURE[:image])
            link = item.attr('href')

            data << {
              title: title,
              extensions: [year],
              link: link,
              image: images_array[image.attr('id').value]
            }
          end
        end
      end

      def file
        return @_file if defined?(@_file)
        @_file ||= File.read('files/van-gogh-paintings.html')
      end

      def doc
        return @_config if defined?(@_config)
        @_doc = Nokogiri::HTML(file)
        end
    end
  end
end