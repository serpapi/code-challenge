# frozen_string_literal: true

require 'json'
require 'nokogiri'

class BaseGalleryParser
  GOOGLE_SEARCH_BASE_URL = 'https://www.google.com'

  def initialize; end

  def parse(page)
    artworks = gallery_items(page).map do |element|
      gallery_item_data(element).reject { |_, v| v.nil? || v.empty? }
    end

    { artworks: artworks }
  end

  def gallery_item_data(element)
    raise NotImplementedError, 'Subclasses must implement this method'
  end
end
