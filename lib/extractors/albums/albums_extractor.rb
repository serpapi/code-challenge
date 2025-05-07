# frozen_string_literal: true

require_relative '../base_extractor'

module Extractors
  module Albums
    class AlbumsExtractor < BaseExtractor
      GALLERY_ATTRID = 'kc:/music/artist:albums'
      SELECTORS_CONFIG_PATH = File.expand_path('selectors_config.yml', __dir__)
    end
  end
end
