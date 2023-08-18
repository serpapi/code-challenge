require 'nokogiri'

GOOGLE_DOMAIN = 'https://www.google.com'

# Class: CarouselParser
# Public interface for parsing input data and extracting relevant information.
class CarouselParser
  def initialize(html)
    @html = html
  end

  def parse
    raise NotImplementedError, "Subclasses have to implement 'parse' method."
  end

  def is_suitable
    raise NotImplementedError, "Subclasses have to implement 'is_suitable' method."
  end

  private

  def create_collection(items)
    items.each_with_object([]) do |item, collection|
      extensions = get_extensions(item)

      record = {
        name: get_item_name(item)
      }

      record[:extensions] = extensions if extensions
      record[:link] = get_link(item)
      record[:image] = get_thumbnail(item)

      collection << record
    end
  end

  # Define default methods that will be used if not overridden by subclasses
  def get_name(item)
    # Default implementation
  end

  def get_extensions(item)
    # Default implementation
  end

  def get_link(item)
    # Default implementation
  end

  def get_image(item)
    # Default implementation
  end
end
