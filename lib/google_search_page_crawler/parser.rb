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
      doc.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a').map do |node|
        parse_artwork(node)
      end
    end

    def parse_artwork(artwork_node)
      {
        "name": artwork_node.css("div > div").first.text,
        "extensions": artwork_node.css("div > div").drop(1).map { |e| e.text.to_s },
        "link": google_url_from_path(artwork_node.attr("href")),
        "image": parse_artwork_image(artwork_node.css("img").first)
      }
    end

    private def parse_artwork_image(img_node)
      if img_node.attr("id")
        "test"
      else
        img_node.attr("data-src")
      end
    end


    private def google_url_from_path(path)
      URI.join("https://www.google.com", path).to_s
    end


  end
end
