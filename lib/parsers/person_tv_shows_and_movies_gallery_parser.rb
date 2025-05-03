# frozen_string_literal: true

class PersonTVShowsAndMoviesGalleryParser < BaseGalleryParser
  def gallery_item_data(element)
    {
      name: gallery_item_name(element),
      extensions: gallery_item_extensions(element),
      link: gallery_item_link(element),
      image: gallery_item_image_src(element)
    }
  end

  private

  def gallery_items(page)
    page.css('div[data-attrid="kc:/people/person:tv-shows-and-movies"] div[data-attrid="kc:/people/person:tv-shows-and-movies"][role="presentation"]')
  end

  def gallery_item_image_src(element)
    img = element.at_css('a[href^="/search?sca_esv"] img')
    img.attribute('src') || img.attribute('data-src')
  end

  def gallery_item_link(element)
    href = element.at_css('a[href^="/search?sca_esv"]')&.attribute('href')
    "#{GOOGLE_SEARCH_BASE_URL}#{href}"
  end

  def gallery_item_name(element)
    element.attribute('title')
  end

  def gallery_item_extensions(element)
    element.css('wp-grid-tile div div').map(&:text)[1..]
  end
end
