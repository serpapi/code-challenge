# typed: strong
# frozen_string_literal: true

require "./src/carousels/base_carousel"
require "./src/carousels/carousel_config"

class GridCarousel < BaseCarousel
  CONFIG = T.let(CarouselConfig.new(
    detect_selector: "g-scrolling-carousel.rlc__slider",
    item_selector: "a.rl_item",
    name_selector: ".title",
    extension_selector: ".uDMnUc span"
  ), CarouselConfig)

  sig { override.returns(CarouselConfig) }
  def self.config
    CONFIG
  end
end
