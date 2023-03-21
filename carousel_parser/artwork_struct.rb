# frozen_string_literal: true

module CarouselParser
  class ArtworkStruct
    attr_reader :name, :extensions, :link, :image

    def initialize(name:, extensions: [], link: , image:)
      @name = name
      @extensions = extensions.freeze
      @link = link
      @image = image
    end

    def to_h
      result = {
        name: name,
        link: link,
        image: image
      }

      # Would use .present? but it's a rails thing
      if extensions.any? { |m| !m.empty? }
        result[:extensions] = extensions
      end

      result
    end

    def to_string
      "#{self.class.name} - name: #{name}, extensions: [#{extensions.join(', ')}], link: #{link}, image: #{image}"
    end

    def to_s
      if image
        image_snippet = image[0..10] + '...' + image[-10..-1]
      else
        image_snippet = ''
      end

      "#{self.class.name} - name: #{name}, extensions: [#{extensions.join(', ')}], link: #{link}, image: #{image_snippet}"
    end
  end
end

