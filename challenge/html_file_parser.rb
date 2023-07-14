require 'nokogiri'

module Challenge
  class HtmlFileParser
    def initialize(filepath)
      @filepath = filepath
    end

    def parse
      html = File.read(@filepath)
      Nokogiri::HTML html
    end
  end
end
