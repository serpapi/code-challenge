# frozen_string_literal: true

require_relative "van_scraper/version"
require "nokogiri"
require "json"

class JSONable
  def to_json(options = {})
    hash = {}
    instance_variables.each do |var|
      hash[var] = instance_variable_get var
    end
    hash.to_json(options)
  end

  def from_json!(string)
    JSON.parse(string).each do |var, val|
      instance_variable_set var, val
    end
  end
end

module VanScraper
  class Error < StandardError; end

  # Receives HTML file and returns extracted data in a hash format
  def self.parse(file_path)
    raise "Missing file_path for parsing" unless file_path

    file = File.read(file_path)
    doc = Nokogiri::HTML(file)
    carrousel = doc.xpath("//g-scrolling-carousel")

    raise "Page does not contain google carrousel" if carrousel.empty?

    Artworks.new(carrousel)
  end

  class Artworks < JSONable
    # @return [Array<Paintings>] List of all paintings from google carrousel
    attr_reader :paintings

    def initialize(carrousel)
      @paintings = get_paintings(carrousel.css(".klitem"))
    end

    def get_paintings(nodes)
      nodes.map { |node| Painting.new(node) }
    end
  end

  class Painting < JSONable
    # @return [String] Name of painting
    attr_reader :name

    # @return [Array] Date of painting
    attr_reader :extensions

    # @return [String] Google link for this painting
    attr_reader :link

    # @return [String] Image found in the thumbnail
    attr_reader :image

    def initialize(node)
      @name = node.attr("aria-label")
      @extensions = node.css(".klmeta").children.map(&:text)
      @link = "https://www.google.com#{node.attr("href")}"
      @image = node.at_css("img").attr("src")
    end
  end
end

artworks = VanScraper.parse("../files/van-gogh-paintings.html")

File.open("artworks-array.json", "w") do |f|
  f.write(JSON.pretty_generate(artworks))
end
