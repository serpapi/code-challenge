require 'nokogiri'

class GoogleSearchPageCrawler
  class Parser
    attr_reader :doc
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def parse
      {
        "artworks": parse_artworks
      }
    end

    def parse_artworks
      doc.css('kc:/visual_art/visual_artist:works"] a').map(&:parse_artwork)
    end

    def parse_artwork(artwork_node)
      {
        "title": artwork_node.css("div > div").first.text,
        extensions: artwork_node.css("div > div").drop(1).map(&:text)
      }
    end
  end
end
