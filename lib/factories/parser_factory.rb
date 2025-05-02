# frozen_string_literal: true

require_relative '../parsers/base_gallery_parser'
Dir[File.join(File.dirname(__FILE__), '..', 'parsers', '*.rb')].sort.each { |file| require file }

# Runs the first eligible parser.
# Running every eligible parser would reproduce SerpAPI.com's core functionality
class ParserFactory
  def self.from_page(page)
    parser_klass(page).new(page)
  end

  def self.parser_klass(page)
    parsers.detect { |parser| parser.eligible?(page) }
  end

  def self.parsers
    BaseGalleryParser.subclasses
  end
end
