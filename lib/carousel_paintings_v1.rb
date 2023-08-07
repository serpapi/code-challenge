require 'carousel'
require 'carousel_painting_tile_v1'

class CarouselPaintingsV1 < Carousel
  CAROUSEL_PARENT_SELECTOR = "//g-scrolling-carousel[@class = 'wqBQjd']".freeze
  CAROUSEL_ITEMS_SELECTOR = './div/div/div/a'.freeze
  CAROUSEL_TILE_KLASS = CarouselPaintingTileV1

  def initialize(document)
    super(document, {
      carousel_parent_selector: CAROUSEL_PARENT_SELECTOR,
      carousel_items_selector: CAROUSEL_ITEMS_SELECTOR,
      carousel_tile_klass: CAROUSEL_TILE_KLASS
    })
  end
end