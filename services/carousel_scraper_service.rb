require_relative "../lib/carousel_parser"

class CarouselScraperService
  def initialize(input_file:)
    @input_file = input_file
  end

  def call
    parser.call.to_json
  end

  private

  def parser
    @parser ||= CarouselParser.new(html_string: File.read(@input_file))
  end
end
