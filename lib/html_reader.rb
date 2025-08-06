# frozen_string_literal: true

require 'nokogiri'

# reads in a html file from path and returns nokogiri html object
class HtmlReader
  def initialize(path)
    @path = path
  end

  def call
    html = File.read(@path)
    Nokogiri::HTML(html)
  end
end
