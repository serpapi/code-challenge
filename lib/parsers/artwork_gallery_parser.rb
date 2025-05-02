# frozen_string_literal: true

class ArtworkGalleryParser < BaseGalleryParser
  def self.elements_selector
    'div[data-attrid="kc:/visual_art/visual_artist:works"] a[href^="/search?sca_esv"]'
  end

  def element_image_src(element)
    img = element.at_css('img[src^="data:image"]')
    img.attribute('data-src') || img.attribute('src')
  end

  def element_link(element)
    "#{GOOGLE_SEARCH_BASE_URL}#{element.attribute('href')}"
  end

  def element_name(element)
    element.xpath('./div/div')&.first&.text
  end

  def element_extensions(element)
    element.xpath('./div/div')[1..].map(&:text).compact.reject(&:empty?)
  end
end
