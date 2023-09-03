# frozen_string_literal: true

class ImageCarrouselScrapper
  module Drivers
    class BaseDriver
      RESULT = Struct.new(:name, :extensions, :link, :image, keyword_init: true)

      attr_reader :file

      def initialize(file)
        @file = file
      end

      def carrousel_list
        raise NotImplementedError
      end
    end
  end
end
