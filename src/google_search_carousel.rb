# typed: strict
# frozen_string_literal: true

require "nokogiri"
require "sorbet-runtime"

require "./src/extracted_item"
require "./src/carousels/control_carousel"
require "./src/carousels/grid_carousel"

class GoogleSearchCarousel
  extend T::Sig

  CAROUSEL_SELECTOR = "#extabar g-scrolling-carousel"
  IMAGE_PATTERN = /'(data:image\/jpeg;base64,\S+)';/
  SUPPORTED_CAROUSELS = T.let([CONTROL_CAROUSEL_CONFIG, GRID_CAROUSEL_CONFIG], T::Array[CarouselConfig])

  sig { params(html: String).void }
  def initialize(html)
    @html = html
    doc = Nokogiri::HTML(html)
    @carousel_node = T.let(doc.css(CAROUSEL_SELECTOR)[0], T.nilable(Nokogiri::XML::Node))

    if has_carousel?
      @config = T.let(carousel_config(doc), T.nilable(CarouselConfig))
    end
  end

  sig { params(google_host: String).returns(T::Array[ExtractedItem]) }
  def extract(google_host = "https://www.google.com")
    return [] unless has_carousel?
    return [] unless @config

    images = T.cast(@html.scan(IMAGE_PATTERN), T::Array[T::Array[String]]).map(&:first)

    T.must(@carousel_node).css(@config.item_selector).each_with_index.map do |item_node, index|
      name = item_node.css(@config.name_selector).text
      link = google_host + item_node["href"]
      image = images[index]
      extensions = item_node.css(@config.extension_selector).map { |node| node.text.not_empty }.compact

      ExtractedItem.new(name: name, link: link, image: image, extensions: Array(extensions))
    end
  end

  private

  sig { returns(T::Boolean) }
  def has_carousel?
    !!@carousel_node
  end

  sig { params(doc: Nokogiri::HTML::Document).returns(T.nilable(CarouselConfig)) }
  def carousel_config(doc)
    SUPPORTED_CAROUSELS.find { |config| doc.css(config.detect_selector).any? }
  end
end
