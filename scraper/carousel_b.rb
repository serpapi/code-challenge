require_relative 'base_gallery'
require_relative 'carousel_item_a'

# gallery type for list-of-popes type gallery
class CarouselB < BaseGallery
  private

  def parse_item(item)
    CarouselItemA.new(item, image_map).to_h
  end

  def container_selector
    'div[role="group"]'
  end

  def item_selector
    'a.klitem-tr'
  end
end
