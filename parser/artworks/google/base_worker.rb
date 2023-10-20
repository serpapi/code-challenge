# frozen_string_literal: true

module Parser
  module Artworks
    module Google
      class BaseWorker
        DEFAULT_EXTENSION = nil
        CAROUSEL_ITEM_HREF_ATTR = 'href'
        IMAGES_REGEXP = %r{function\(\)\{var s='(data:image\/jpeg;base64,\S+)'}.freeze

        ResultItem = Struct.new(:name, :link, :extensions, :image)

        def initialize(**opt)
          @input = opt[:input].read
          @output = opt[:output]
        end

        def call
          raw_data = carousel.map.each_with_index do |item, index|
            ResultItem.new(
              item.at_css(klass::CAROUSEL_ITEM_NAME_TAG).text,
              "https://google.com#{link(item)}",
              extensions(item),
              images[index]
            )
          end

          output.render(raw_data)
        end

        private

        attr_reader :input, :output

        def link(_item)
          raise NotImplemented
        end

        def extensions(item)
          div = item.at_css(klass::CAROUSEL_ITEM_YEAR_TAG)
          div ? [div.text] : klass::DEFAULT_EXTENSION
        end

        def images
          @images ||= input.scan(klass::IMAGES_REGEXP).map { |image| image[0] }
        end

        def carousel
          @carousel ||= Nokogiri::HTML(input).css(klass::CAROUSEL_ITEM_TAG)
        end

        def klass
          self.class
        end
      end
    end
  end
end
