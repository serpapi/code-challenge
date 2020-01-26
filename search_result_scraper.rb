require 'nokogiri'
require_relative 'image'

class SearchResultScraper

  attr_reader :doc, :file

  def initialize(path)
    @file = File.open(path).read
    @doc = Nokogiri::HTML file
  end

  def get_results
    result = []

    items.each_with_index do |item, index|
      image = images[index] ? images[index][0] : nil

      result << Image.new(item, image).fetch_details
    end

    {artworks: result}
  end

  private

  def items
    doc.css('.klitem')
  end

  def images
    file.scan(%r{var s='(data:image\/[^;]+;base64,\S+);})
  end
end