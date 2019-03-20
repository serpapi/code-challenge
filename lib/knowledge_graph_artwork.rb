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

  def artwork
    parser.css(".klitem-tr .klitem").map do |el|
      href = el.get_attribute("href")
      {
        name: el.css(".kltat").text,
        date: [
          el.css(".klmeta").text
        ],
        link: href.include?("google.com") ? href : "https://www.google.com#{href}"
      }
    end
  end
end
