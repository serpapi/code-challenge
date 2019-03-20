class KnowledgeGraphArtwork
  attr_reader :parser

  def initialize(parser)
    @parser = parser
  end

  def self.parse(response)
    return self.new(Nokogiri::HTML(response))
  end

  def title
    parser.xpath('//title').text
  end


end
