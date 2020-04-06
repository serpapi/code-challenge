# typed: strict
# frozen_string_literal: true

require "nokogiri"
require "sorbet-runtime"

require "./src/extracted_item"
require "./src/carousels/control_carousel"

class GoogleSearchCarousel
  extend T::Sig

  CAROUSEL_SELECTOR = "#extabar g-scrolling-carousel"
  IMAGE_PATTERN = /'(data:image\/jpeg;base64,\S+)';/

  sig { params(html: String).void }
  def initialize(html)
    @html = html
    doc = Nokogiri::HTML(html)
    @carousel_node = T.let(doc.css(CAROUSEL_SELECTOR)[0], T.nilable(Nokogiri::XML::Node))
  end

  sig { params(google_host: String).returns(T::Array[ExtractedItem]) }
  def extract(google_host = "https://www.google.com")
    return [] unless has_carousel?

    images = T.cast(@html.scan(IMAGE_PATTERN), T::Array[T::Array[String]]).map(&:first)

    T.must(@carousel_node).css(CONTROL_CAROUSEL_CONFIG.item_selector).each_with_index.map do |item_node, index|
      name = item_node.css(CONTROL_CAROUSEL_CONFIG.name_selector).text
      link = google_host + item_node["href"]
      image = images[index]
      extensions = item_node.css(CONTROL_CAROUSEL_CONFIG.extension_selector).text.not_empty

      ExtractedItem.new(name: name, link: link, image: image, extensions: Array(extensions))
    end
  end

  private

  sig { returns(T::Boolean) }
  def has_carousel?
    !!@carousel_node
  end
end
