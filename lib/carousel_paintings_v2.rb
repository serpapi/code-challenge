require 'carousel'
require 'carousel_painting_tile_v2'

class CarouselPaintingsV2 < Carousel
  CAROUSEL_PARENT_SELECTOR = "//g-scrolling-carousel[@class = 'sfS5Re']".freeze
  CAROUSEL_ITEMS_SELECTOR = './div/div/a'.freeze
  CAROUSEL_TILE_KLASS = CarouselPaintingTileV2

  def initialize(document)
    super(document, {
      carousel_parent_selector: CAROUSEL_PARENT_SELECTOR,
      carousel_items_selector: CAROUSEL_ITEMS_SELECTOR,
      carousel_tile_klass: CAROUSEL_TILE_KLASS
    })
  end
end