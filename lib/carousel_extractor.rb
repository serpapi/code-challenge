# frozen_string_literal: true

require "nokogiri"
require "uri"

# Extracts a Google Knowledge Graph entity carousel into a uniform array.
# Located by stable `data-attrid` schema, never by minified classes or
# per-request ids, which are not stable.
class CarouselExtractor
  CAROUSEL_ATTRIDS = [
    "kc:/visual_art/visual_artist:works" # paintings
  ].freeze
  GOOGLE = "https://www.google.com"
  private_constant(*constants(false))

  def self.call(html) = new(html).entries

  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  def entries
    return [] unless carousel

    carousel.css("a").filter_map { |anchor| entry_for(anchor) }
  end

  private

  attr_reader :doc

  def carousel
    @carousel ||= CAROUSEL_ATTRIDS.filter_map do |id|
      doc.at_css(%([data-attrid="#{id}"]))
    end.first
  end

  # name and extensions come from the leaf text divs ([name, *extensions]);
  # name falls back to img@alt. extensions is omitted entirely when a tile has
  # no secondary line.
  def entry_for(anchor)
    image = anchor.at_css("img")
    return unless image && anchor["href"]

    leaves = text_leaves(anchor)
    extensions = leaves.drop(1)

    {
      "name" => leaves.first || image["alt"],
      **(extensions.any? ? { "extensions" => extensions } : {}),
      "link" => URI.join(GOOGLE, anchor["href"]).to_s
    }
  end

  def text_leaves(anchor)
    anchor.css("div")
          .reject { |d| d.at_css("div") }
          .map { |d| d.text.strip }
          .reject(&:empty?)
  end
end
