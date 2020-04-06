# typed: strict
# frozen_string_literal: true

class ExtractedItem < T::Struct
  const :name, String
  const :link, String
  const :image, T.nilable(String)
  const :extensions, T::Array[String]
end
