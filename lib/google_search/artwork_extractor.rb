# frozen_string_literal: true

require "nokolexbor"

require_relative "artwork_page"

module GoogleSearch
  class ArtworkExtractor
    def initialize(html)
      @html = html
    end

    def call
      document = Nokolexbor::HTML(html_for_parsing)
      ArtworkPage.new(document).call
    end

    private
      def html_for_parsing
        html = @html.dup
        html.force_encoding(Encoding::UTF_8) if html.encoding == Encoding::BINARY
        html
      end
  end
end
