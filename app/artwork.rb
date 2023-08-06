# frozen_string_literal: true

# Represents an artwork
class Artwork
  GOOGLE_HOST = 'https://www.google.com'

  def initialize(node, nodes_id_source_map)
    @node = node
    @nodes_id_source_map = nodes_id_source_map
  end

  def to_h
    {
      name: name,
      extensions: extensions,
      link: link,
      image: image,
    }
  end

  private

  attr_reader :node, :nodes_id_source_map

  def name
    @name ||= node.at('div.kltat').text.gsub(/\s+/, ' ').strip
  end

  def extensions
    return @extensions unless @extensions.nil?

    date = node.at('div.klmeta')
    return [] unless date

    date = date.text.gsub(/\s+/, ' ').strip
    @extensions = [date]
  end

  def link
    @link ||= "#{GOOGLE_HOST}#{node['href']}"
  end

  def image
    @image = nodes_id_source_map[node.at('img')['id']]
  end
end
