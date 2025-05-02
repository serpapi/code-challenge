# frozen_string_literal: true

class AuthorBooksGalleryParser < BaseGalleryParser
  def self.elements_selector
    'div[data-attrid="kc:/book/author:books only"] div[data-attrid="kc:/book/author:books only"][role="presentation"]'
  end

  def element_image_src(element)
    img = element.at_css('a[href^="/search?sca_esv"] img')
    img.attribute('src') || img.attribute('data-src')
  end

  def element_link(element)
    href = element.at_css('a[href^="/search?sca_esv"]')&.attribute('href')
    "#{GOOGLE_SEARCH_BASE_URL}#{href}"
  end

  def element_name(element)
    element.attribute('title')
  end

  def element_extensions(element)
    element.css('wp-grid-tile div div').map(&:text)[1..]
  end
end
