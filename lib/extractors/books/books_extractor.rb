# frozen_string_literal: true

require_relative '../base_extractor'

module Extractors
  module Books
    class BooksExtractor < BaseExtractor
      GALLERY_ATTRID = 'kc:/book/author:books only'
      SELECTORS_CONFIG_PATH = File.expand_path('selectors_config.yml', __dir__)
    end
  end
end
