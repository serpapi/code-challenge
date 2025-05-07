# frozen_string_literal: true

require_relative '../base_extractor'

# PaintingsExtractor extracts artworks from painting carousels (e.g., Google search result pages).
module Extractors
  module Paintings
    class PaintingsExtractor < BaseExtractor
      GALLERY_ATTRID = 'kc:/visual_art/visual_artist:works'
      SELECTORS_CONFIG_PATH = File.expand_path('selectors_config.yml', __dir__)
    end
  end
end
