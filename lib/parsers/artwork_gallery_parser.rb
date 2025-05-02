class ArtworkGalleryParser < BaseGalleryParser
  def gallery_item_data(element)
    {
      name:       gallery_item_name(element),
      extensions: gallery_item_extensions(element),
      link:       gallery_item_link(element),
      image:      gallery_item_image_src(element)
    }
  end

  def gallery_items(page)
    page.css('div[data-attrid="kc:/visual_art/visual_artist:works"] a[href^="/search?sca_esv"]')
  end

  def gallery_item_image_src(element)
    img = element.at_css('img[src^="data:image"]')
    img.attribute('data-src') || img.attribute('src')
  end

  def gallery_item_link(element)
    "#{GOOGLE_SEARCH_BASE_URL}#{element.attribute('href')}"
  end

  def gallery_item_name(element)
    element.xpath('./div/div')&.first&.text
  end

  def gallery_item_extensions(element)
    element.xpath('./div/div')[1..-1].map { |e| e.text }.compact.reject(&:empty?)
  end
end
