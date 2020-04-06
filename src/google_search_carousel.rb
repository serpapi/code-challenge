# typed: strict
# frozen_string_literal: true

require "nokogiri"
require "sorbet-runtime"

require "./src/extracted_item"

class GoogleSearchCarousel
  extend T::Sig

  CAROUSEL_SELECTOR = "#extabar g-scrolling-carousel"

  sig { params(html: String).void }
  def initialize(html)
    @html = html
    doc = Nokogiri::HTML(html)
    @carousel_node = T.let(doc.css(CAROUSEL_SELECTOR)[0], T.nilable(Nokogiri::XML::Node))
  end

  sig { params(google_host: String).returns(T::Array[ExtractedItem]) }
  def extract(google_host = "https://www.google.com")
    return [] unless has_carousel?

    []
  end

  private

  sig { returns(T::Boolean) }
  def has_carousel?
    !!@carousel_node
  end
end
