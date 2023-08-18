# frozen_string_literal: true

require "nokogiri"

module Google
  BASE_URL = "https://www.google.com"

  # Base class for parser implementations
  class SearchResultParser
    attr_accessor :doc

    def initialize(doc)
      self.doc = doc
    end
  end
end
