# frozen_string_literal: true

class BaseGalleryParser
  GOOGLE_SEARCH_BASE_URL = 'https://www.google.com'

  def self.eligible?(page)
    page.css(elements_selector).any?
  end

  def initialize(page)
    @page = page
  end

  def as_json
    { artworks: data }
  end

  def data
    elements.map do |element|
      element_data(element).reject { |_, v| v.nil? || v.empty? }
    end
  end

  def elements
    @page.css(self.class.elements_selector)
  end

  def element_data(element)
    {
      name: element_name(element),
      extensions: element_extensions(element),
      link: element_link(element),
      image: element_image_src(element)
    }
  end

  private

  def elements_selector
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  # These methods seem to belong to the Element class.
  # Although, I don't want to overcomplicate the code for now.
  # Iterative approach.
  def element_name(element)
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  def element_extensions(element)
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  def element_link(element)
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  def element_image_src(element)
    raise NotImplementedError, 'Subclasses must implement this method'
  end
end
