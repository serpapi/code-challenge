# typed: strong
# frozen_string_literal: true

require "./src/carousels/carousel_config"

GRID_CAROUSEL_CONFIG = T.let(CarouselConfig.new(
    detect_selector: "g-scrolling-carousel.rlc__slider",
    item_selector: "a.rl_item",
    name_selector: ".title",
    extension_selector: ".uDMnUc span"
  ), CarouselConfig)

