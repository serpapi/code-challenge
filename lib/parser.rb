require_relative '../boot'
require 'nokogiri'

class Parser
  attr_reader :document
  # Nokogiri document
  def initialize(document)
    @document = Nokogiri::HTML(document)
  end

  def paintings
    @paintings ||= begin
      tiles = document.css("g-scrolling-carousel:first a")
      tiles.map { |tile| PaintingTile.new(tile) }.find_all { |tile| tile.name }
    end
  end

  def to_serializable_hash
    @to_serializable_hash ||= {
      "knowledge_graph" => {
        "artworks" => self.paintings.map(&:to_serializable_hash)
      }
    }
  end
end

class PaintingTile
  HOST = "https://www.google.com"

  attr_accessor :tile

  def initialize(tile)
    @tile = tile
  end

  def name
    @name ||= tile.attributes["aria-label"]&.value
  end

  def extensions
    @extensions ||= tile.css(".klmeta").map(&:text)
  end

  def link
    @link ||= begin
      value = tile.attributes["href"]&.value
      "#{HOST}#{value}"
    end
  end

  def image
    @image ||= begin
      img = tile.css("img").first
      img.attributes["src"].value if img && img.attributes["src"] 
    end
  end

  def to_serializable_hash
    @to_serializable_hash ||= begin
      hsh = {}

      hsh["name"] = self.name
      hsh["extensions"] = self.extensions if self.extensions && !self.extensions.empty?
      hsh["link"] = self.link
      hsh["image"] = self.image

      hsh
    end
  end
end
