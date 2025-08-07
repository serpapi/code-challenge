# frozen_string_literal: true

require './lib/html_reader'
require './lib/carousel_parser'
require 'json'

# Reads in a html file and returns structured JSON for the carousel
class Scraper
  def initialize(path)
    @path = path
  end

  def call
    html = HtmlReader.new(path).call
    parsed_result = CarouselParser.new(html).call
    parsed_result.to_json
  end

  private

  attr_reader :path
end
