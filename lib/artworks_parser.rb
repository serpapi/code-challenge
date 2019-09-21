# frozen_string_literal: true
require 'nokogiri'
require_relative './artwork_parser.rb'

class ArtworksParser
  def call(page)
    page.css('.klitem').map do |element|
      ArtworkParser.new(element).call
    end
  end
end
