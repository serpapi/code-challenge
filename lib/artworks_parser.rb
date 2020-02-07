# frozen_string_literal: true

require 'nokogiri'
require 'pry'

require './lib/artwork'

class ArtworksParser
  IMAGES_REGEX = %r{var s='data:image/jpeg;base64,([a-zA-Z0-9+/\\]+)?'}.freeze
  BASE_URL = 'https://www.google.com'

  attr_reader :artworks

  def self.parse(body)
    new(body).parse
  end

  def initialize(body)
    @body = body
    @artworks = []
  end

  def parse
    doc.css('.klitem-tr .klitem').each_with_index do |el, index|
      artwork = Artwork.new
      artwork.name = el.attr('aria-label')
      artwork.link = "#{BASE_URL}#{el.attr('href')}"
      if image = images[index]
        artwork.image = 'data:image/jpeg;base64,' + image[0].delete('\\')
      end
      artwork.extensions = el.css('.klmeta').map(&:text)
      @artworks << artwork
    end
    self
  end

  private

  attr_reader :body, :doc

  def images
    @images ||= body.scan(IMAGES_REGEX)
  end

  def doc
    @doc ||= Nokogiri::HTML.parse(body)
  end
end
