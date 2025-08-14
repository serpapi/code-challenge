require 'nokogiri'
require 'uri'

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
        "extensions": artwork_node.css("div > div").drop(1).map(&:text),
        "link": google_url_from_path(artwork_node.css("a").first.attr("href"))
      }
    end

    private def google_url_from_path(path)
      URI.join("https://www.google.com", path).to_s
    end
  end
end
