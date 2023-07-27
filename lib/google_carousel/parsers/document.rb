require 'nokolexbor'

module GoogleCarousel
  module Parser
    module Docuemnt

      attr_reader :raw_html

      def initialize(raw_html)
        @raw_html = raw_html
      end

      def parse
        Nokolexbor::HTML(raw_html.encode('utf-8'))
      end
    end
  end
end
