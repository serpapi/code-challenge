module GoogleCarousel
  module Extract
    class CarouselImage

      attr_reader :data, :img_sources

      IMG_REGEX = /\(function\(\)\{var s\=\'(.*?)\'\;var ii\=\[\'(.*?)\'\]/

      def initialize(data)
        @data = data
        @img_sources = {}
      end

      def fetch_images
        if img_sources.empty?
          # [[img_source, img_id]]
          image_sources_list.each do |obj|
            img_sources[obj[1]] = obj[0]
          end
        end

        img_sources
      end

      private

      def script_tags
        @script_tags ||= data.css('script')
      end

      def image_scripts
        @image_scripts ||= script_tags.select { |x| x.content.include? '_setImagesSrc' }
      end

      def image_script_str
        @image_script_str ||= image_scripts.map(&:content).join(',')
      end

      def image_sources_list
        @image_sources_list ||= image_script_str.scan(IMG_REGEX)
      end
    end
  end
end
