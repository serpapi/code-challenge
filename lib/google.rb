require 'bundler/setup'
require 'json'
require 'pry'

Bundler.require(:default)

require 'parser'

module Google
  class Artworks
    attr_reader :items

    def initialize(items: [])
      @items = items
    end

    def to_hash
      {
        "artworks" => items.map(&:to_hash)
      }
    end

    def to_json
      to_hash.to_json
    end
  end

  class ShowcaseItem
    def self.from_node(node)
      new(
        name: node["aria-label"],
        link: "https://www.google.com#{node["href"]}",
        image: node.at_css("img")["src"].to_s,
        extensions: node.css(".klmeta > ::text").map(&:to_s)
      )
    end

    attr_reader :name, :link, :image, :extensions

    def initialize(name:, link:, image:, extensions: nil)
      @name = name
      @link = link
      @image = image
      @extensions = Array(extensions)
    end

    def to_hash
      {
        "name" => name,
        "link" => link,
        "image" => image,
        "extensions" => extensions
      }
    end
  end

  class SearchPage
    def initialize(file_path, parser: Parser)
      @parser = parser.new(file_path)
    end

    def doc
      @doc ||= @parser.parse
    end

    def artworks
      Artworks.new(
        items: doc.css('.appcenter .klitem').map do |item|
          ShowcaseItem.from_node(item)
        end
      )
    end
  end
end
