require_relative './base.rb'
require 'uri'

module Parsers
  class CarouselItem  < Parsers::Base
    def name
      extract_value(:name).text
    end

    def extensions
      [extract_value(:extensions).first&.text].compact
    end

    def link
      URI.join('https://www.google.com', extract_value(:link).text).to_s
    end

    def image
      images = extract_value(:image)
      return if images.empty?

      images.first['src']
    end
  end
end
