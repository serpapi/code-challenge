# frozen_string_literal: true

module Parsers
  # Nokogiri wrapper service
  # Returns a parsed document
  class NokogiriHtmlParser
    attr_reader :filepath

    def initialize(filepath:)
      @filepath = filepath
    end

    def call
      File.open(filepath) do |file|
        Nokogiri::HTML(file, nil, Encoding::UTF_8.to_s)
      end
    end
  end
end
