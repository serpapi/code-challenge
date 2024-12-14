require_relative 'base_gallery'
require_relative 'carousel_item_a'

# gallery type for van-gogh-paintings type gallery
class CarouselA < BaseGallery
  private

  def parse_item(item)
    CarouselItemA.new(item, image_map).to_h
  end

  def container_selector
    'g-scrolling-carousel'
  end

  def item_selector
    'a.klitem'
  end
end
