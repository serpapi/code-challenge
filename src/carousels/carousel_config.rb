# typed: strict
# frozen_string_literal: true

class CarouselConfig < T::Struct
  const :detect_selector, String
  const :item_selector, String
  const :name_selector, String
  const :extension_selector, String
end
