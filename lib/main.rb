require_relative './parsers/klitem_parser'
require_relative './parsers/klitem_parser_2023'
require_relative 'carousel_parser'

class Main
  def initialize(html)
    @html = html
  end

  def parse_automated
    parsers = [KlitemParser, KlitemParser2023]
    collection = []

    parsers.each do |current_parser|
      parser = current_parser.new(@html)
      collection = parser.parse if parser.is_suitable
    end

    collection
  end
end
