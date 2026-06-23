# frozen_string_literal: true

require "nokogiri"

# Extracts a Google Knowledge Graph entity carousel (e.g.: paintings, albums,
# buildings, movie cast, etc.) into a uniform array of objects:
# `{ name:, extensions:, link:, image: }`.
class CarouselExtractor
  def self.call(_html) = []
end
