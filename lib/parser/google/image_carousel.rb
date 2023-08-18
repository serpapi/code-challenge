# frozen_string_literal: true

module Parser
  module Google
    BASE_SEARCH_URL = 'https://www.google.com'

    class ImageCarousel
      attr_reader :html, :page

      def initialize(html)
        @html = html
        @page = Nokogiri::HTML(@html, nil, Encoding::UTF_8.to_s)
      end

      def carousel
        @carousel ||= page.css('g-scrolling-carousel').first
      end

      def image_elements
        @image_elements ||= begin
          return [] if carousel.nil?

          carousel.css('a').map do |element|
            ImageContainer.new(element)
          end
        end
      end

      def to_hash
        @to_hash ||= {
          artworks: image_elements.map do |image_element|
            artwork_json = {}
            artwork_json[:name] = image_element.name
            artwork_json[:extensions] = image_element.extensions unless image_element.extensions.nil?
            artwork_json[:link] = image_element.link
            artwork_json[:image] = image_base64[image_element.image_id]
            artwork_json
          end
        }
      end

      def to_json(*_args)
        to_hash.to_json
      end

      private

      def image_base64
        @image_base64 ||= begin
          scripts = page.css('script').select { |x| x.text.include? '_setImagesSrc' }.first
          return {} if scripts.nil?

          scripts
            .children.text
            .split(";(function(){var s='")
            .select { |x| x.include? 'data:image/jpeg;base64' }
            .map { |x| x.split("';var ii=['") }
            .to_h { |k, v| [v.chomp(';').chomp("'];_setImagesSrc(ii,s);})()"), k.tr('\\', '')] }
        end
      end
    end

    class ImageContainer
      def initialize(image_element)
        @image_element = image_element
      end

      def name
        @name ||= @image_element['aria-label']
      end

      def extensions
        @extensions ||= begin
          extension = @image_element.css('div')
          return nil if extension.size < 5

          created_at = extension.last&.text
          [created_at] if created_at
        end
      end

      def link
        @link ||= "#{BASE_SEARCH_URL}#{@image_element['href']}"
      end

      def image_id
        @image_id ||= @image_element.css('img').first['id']
      end
    end
  end
end
