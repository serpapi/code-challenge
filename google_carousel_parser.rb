require 'bundler/setup'
require 'nokogiri'
require File.expand_path '../carousel_card_wrapper', __FILE__

class GoogleCarouselParser
  def initialize(file_path)
    @file_content = File.open(file_path).read
  end

  def document
    Nokogiri::HTML(@file_content)
  end

  def result
    records = []

    columns.each do |col|
      records << CarouselCardWrapper.new(col, @file_content).perform
    end

    return {artworks: records}
  end

  def columns
    document.css('.klitem-tr')
  end
end

