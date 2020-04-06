# typed: strict
# frozen_string_literal: true

class CarouselConfig < T::Struct
  const :item_selector, String
  const :name_selector, String
  const :extension_selector, String
end
