require 'nokogiri'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types()
end

class GoogleSearchPageCrawler
  class Artwork < Dry::Struct
    attribute :name, Types::String.default("")
    attribute :extensions, Types::Array.of(Types::String).default([])
    attribute :link, Types::String.default("")
    attribute :image, Types::String.default("")
  end

  class ArtworkList < Dry::Struct
    attribute :artworks, Types::Array.of(Artwork).default([])
  end

  class Parser
    attr_reader :doc
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def parse
      ArtworkList.new(artworks: parse_artworks)
    end

    def parse_artworks
      doc.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a').map do |node|
        parse_artwork(node)
      end
    end

    def parse_artwork(artwork_node)
      Artwork.new({
        name: artwork_node.css("div > div").first.text,
        extensions: artwork_node.css("div > div").drop(1).map { |e| e.text.to_s },
        link: google_url_from_path(artwork_node.attr("href")),
        image: parse_artwork_image(artwork_node.css("img").first)
      })
    end

    private def parse_artwork_image(img_node)
      if image_id = img_node.attr("id")
        thumbnail_replace_script = doc.css("script").find { |script| script.text.include?(image_id) }
        base64_image = thumbnail_replace_script.text.match(/var s='(data:image[^']+)'/)

        # some chars such as '=' are encoded as hex in the script
        base64_image[1].gsub(/\\x([0-9a-fA-F]{2})/) { [$1].pack("H2") }
      else
        img_node.attr("data-src")
      end
    end

    private def google_url_from_path(path)
      URI.join("https://www.google.com", path).to_s
    end


  end
end
