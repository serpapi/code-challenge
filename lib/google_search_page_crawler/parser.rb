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
      if is_small_carrousel = doc.css('div[data-attrid="kc:/visual_art/visual_artist:works"] [role="list"]').any?
        doc.css('div[data-attrid="kc:/visual_art/visual_artist:works"] [role="list"] a').map do |node|
          parse_small_carrousel_artwork(node.parent)
        end
      else
        doc.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a').map do |node|
          parse_big_carrousel_artwork(node)
        end
      end

    end

    def parse_small_carrousel_artwork(artwork_node)
      text_nodes = artwork_node.search('text()').map(&:text).reject(&:empty?)

      image_node = artwork_node.css("img").first

      image = if image_id = image_node.attr("id")
        fetch_base64_data_for_image(image_node, image_id)
      else
        image_node.attr("src")
      end


      Artwork.new({
        name: text_nodes.first,
        extensions: text_nodes.drop(1),
        link: google_url_from_path(artwork_node.at_css("a").attr("href")),
        image:
      })
    end

    def parse_big_carrousel_artwork(artwork_node)
      text_nodes = artwork_node.search('text()').map(&:text).reject(&:empty?)

      image_node = artwork_node.css("img").first
      image = if image_id = image_node.attr("id")
        fetch_base64_data_for_image(image_node, image_id)
      else
        image_node.attr("data-src")
      end

      Artwork.new({
        name: text_nodes.first,
        extensions: text_nodes.drop(1),
        link: google_url_from_path(artwork_node.attr("href")),
        image:
      })
    end

    private def fetch_base64_data_for_image(img_node, image_id)
      thumbnail_replace_script = doc.css("script").find { |script| script.text.include?(image_id) }
      base64_image = thumbnail_replace_script.text.match(/var s='(data:image[^']+)'/)

      # some chars such as '=' are encoded as hex in the script
      base64_image[1].gsub(/\\x([0-9a-fA-F]{2})/) { [$1].pack("H2") }
    end

    private def google_url_from_path(path)
      URI.join("https://www.google.com", path).to_s
    end
  end
end
