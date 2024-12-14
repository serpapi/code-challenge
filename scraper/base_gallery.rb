require_relative 'image_map'
require_relative 'element_not_found_error'

class BaseGallery
  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end

  def to_a
    container = doc.at_css(container_selector)

    raise ElementNotFoundError unless container

    container.css(item_selector).map { parse_item(_1) }
  end

  private

  def parse_item(item)
    raise NotImplementedError
  end

  def item_selector
    raise NotImplementedError
  end

  def container_selector
    raise NotImplementedError
  end

  def image_map
    @image_map ||= ImageMap.new(doc).to_h
  end
end
