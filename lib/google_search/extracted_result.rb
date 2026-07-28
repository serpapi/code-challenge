# frozen_string_literal: true

require 'json'

module GoogleSearch
  # A single item extracted from a search results carousel.
  ExtractedResult = Data.define(:name, :extensions, :link, :image) do
    def initialize(name:, link:, image:, extensions: nil)
      super
    end

    def to_h
      hash = { name: name }
      hash[:extensions] = extensions unless extensions.nil? || extensions.empty?
      hash[:link] = link
      hash[:image] = image
      hash
    end

    def to_json(*)
      to_h.to_json(*)
    end
  end
end
