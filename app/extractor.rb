# frozen_string_literal: true

require 'json'
require 'nokogiri'
require_relative 'artwork'

# Main class to extract data from the HTML file
class Extractor
  attr_reader :result

  def initialize
    file_path = 'files/van-gogh-paintings.html'
    @html = File.read(file_path)
    @doc = Nokogiri::HTML(html)
  end

  def extract
    @result = { artworks: artworks }
  end

  def to_json(options = {})
    @result.to_json(options)
  end

  private

  attr_reader :html, :doc

  def artworks
    @artworks ||= doc.css('a.klitem').each_with_object([]) do |node, result|
      artwork = Artwork.new(node, artwork_nodes_id_source_map)
      result << artwork.to_h
    end
  end

  def artwork_nodes_id_source_map
    @artwork_nodes_id_source_map ||= doc.css('script').each_with_object({}) do |script_tag, result|
      script_content = script_tag.text

      next unless script_content.include?('function _setImagesSrc(')

      array_content = script_content.split('(function(){')
      array_content[1..].each do |element|
        result[artwork_node_id(element)] = artwork_node_src(element)
      end
    end
  end

  def artwork_node_id(element)
    element.match(/var ii=\[(.*?)\];/m)[1].gsub("'", '')
  end

  def artwork_node_src(element)
    element.match(/var s='(.*)';/m)[1].gsub("\\", '')
  end
end
