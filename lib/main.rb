require_relative './parsers/klitem_parser'
require_relative 'carousel_parser'

class Main
  def initialize(html)
    @html = html
  end

  def parse
    parser = KlitemParser.new(@html)
    result = parser.parse

    # File.write(File.join(__dir__, '../files/export.json'), result)
  end

  collection = []
  def parse_automated
    parsers = [KlitemParser]

    parsers.each do |parser_class|
      parser = parser_class.new(@html)
      result = parser.parse
      puts result[0]
    end
  end
end
