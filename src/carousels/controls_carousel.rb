# typed: strong
# frozen_string_literal: true

require "./src/carousels/base_carousel"
require "./src/carousels/carousel_config"

class ControlsCarousel < BaseCarousel
  extend T::Sig

  CONFIG = T.let(CarouselConfig.new(
    detect_selector: ".klcc > g-scrolling-carousel",
    item_selector: "a[jscontroller]",
    name_selector: ".kltat",
    extension_selector: ".klmeta"
  ), CarouselConfig)

  sig { override.returns(CarouselConfig) }
  def self.config
    CONFIG
  end
end
