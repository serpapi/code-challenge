require 'nokogiri'

class ArtworksParser
  attr_reader :doc

  def initialize(path)
    @doc = File.open(path) { |f| Nokogiri::HTML(f) }
  end

  def run
    []
  end
end
