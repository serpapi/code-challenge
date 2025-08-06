# frozen_string_literal: true
require 'nokogiri'

class HtmlReader
  def initialize(path)
    @path = path
  end

  def call
    html = File.read(@path)
    Nokogiri::HTML(html)
  end
end
