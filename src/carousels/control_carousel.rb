# typed: strong
# frozen_string_literal: true

require "./src/carousels/carousel_config"

CONTROL_CAROUSEL_CONFIG = T.let(CarouselConfig.new(
  detect_selector: ".klcc > g-scrolling-carousel",
    item_selector: "a[jscontroller]",
    name_selector: ".kltat",
    extension_selector: ".klmeta"
  ), CarouselConfig)
