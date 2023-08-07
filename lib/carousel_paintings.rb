class CarouselPaintings
  def initialize(document, parsers)
    @document = document
    @parsers = parsers
  end

  def data
    @parsers.each do |parser|
      p = parser.new(@document)
      @parser_data = p.data
      return @parser_data unless @parser_data[:paintings].empty?
    rescue
      next
    end
    nil
  end

  def to_json
    @parser_data.to_json
  end
end