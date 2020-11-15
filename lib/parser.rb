require 'nokogiri'
require 'parsers/artwork'

class Parser
  def initialize(path:)
    @file = File.read(path)
  end

  def artworks
    Parsers::Artworks.new(file).parse
  end

  private

  attr_reader :file
end
