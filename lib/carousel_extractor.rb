# frozen_string_literal: true

require "nokogiri"

# Extracts a Google Knowledge Graph entity carousel into a uniform array.
# Located by stable `data-attrid` schema, never by minified classes or
# per-request ids, are not stable.
class CarouselExtractor
  CAROUSEL_ATTRIDS = [
    "kc:/visual_art/visual_artist:works" # paintings
  ].freeze

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

  def entry_for(anchor)
    image = anchor.at_css("img")
    return unless image && anchor["href"]

    {}
  end
end
