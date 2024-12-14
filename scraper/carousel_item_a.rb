require 'cgi'
require 'debug'

class CarouselItemA
  HOST = 'https://www.google.com'

  attr_reader :node, :image_map

  def initialize(node, image_map)
    @node = node
    @image_map = image_map
  end

  def to_h
    { name:, link:, image: }.merge(extensions)
  end

  private

  def name
    node['aria-label']
  end

  def link
    HOST + node['href']
  end

  def image
    image_map[image_id]
  end

  def image_id
    node.at_css('img').to_h['id']
  end

  def extensions
    # meta parameters can contain escaped html symbols, we need to unescape them for clear output
    meta.any? ? { extensions: meta.map { CGI.unescapeHTML(_1) } } : {}
  end

  def meta
    # initially meta parameter tags contained .ellip class
    # but for new carousels and grids there's no such classes on div tags
    # idea here is to collect all text parts represented in leaf tags
    # and filter parts that are already included in name
    node
      .xpath('.//div[not(*) and normalize-space()]')
      .map { _1.text.strip }
      .reject(&:empty?)
      .reject { name.include?(_1) }
  end
end
