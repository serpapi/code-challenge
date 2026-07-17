# frozen_string_literal: true

module GoogleSearch
  class Error < StandardError; end
  class ArtworkLayoutError < Error; end
  class ArtworkSectionNotFound < ArtworkLayoutError; end
  class MalformedCard < Error; end
  class InlineImageSourceError < Error; end
  class InvalidLink < Error; end
end

require_relative "google_search/inline_image_sources"
require_relative "google_search/artwork_layout_rules"
require_relative "google_search/artwork_page"
require_relative "google_search/artwork_extractor"
