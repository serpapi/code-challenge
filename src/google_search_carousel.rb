# typed: strict
# frozen_string_literal: true

require "nokogiri"
require "sorbet-runtime"
require "./src/core_ext"
require "./src/extracted_item"
require "./src/carousels/base_carousel"
require "./src/carousels/controls_carousel"
require "./src/carousels/no_controls_carousel"
require "./src/carousels/grid_carousel"

class GoogleSearchCarousel
  extend T::Sig

  CAROUSEL_SELECTOR = "#extabar g-scrolling-carousel"
  IMAGE_PATTERN = /'(data:image\/jpeg;base64,\S+)';/
  SUPPORTED_CAROUSELS = T.let([ControlsCarousel, NoControlsCarousel, GridCarousel], T::Array[T.class_of(BaseCarousel)])

  sig { params(html: String).void }
  def initialize(html)
    @html = html
    doc = Nokogiri::HTML(html)
    @carousel_node = T.let(doc.css(CAROUSEL_SELECTOR)[0], T.nilable(Nokogiri::XML::Node))

    if has_carousel?
      @carousel_klass = T.let(carousel_type_class(doc), T.nilable(T.class_of(BaseCarousel)))
      @carousel_instance = T.let(@carousel_klass.new(html, doc), BaseCarousel) if @carousel_klass
    end
  end

  sig { params(google_host: String).returns(T::Array[ExtractedItem]) }
  def extract(google_host = "https://www.google.com")
    return [] unless has_carousel?
    return [] unless @carousel_klass

    config = @carousel_klass.config

    images = T.cast(@html.scan(IMAGE_PATTERN), T::Array[T::Array[String]]).map(&:first)

    T.must(@carousel_node).css(config.item_selector).each_with_index.map do |item_node, index|
      item_node = @carousel_instance.transform_item_node(item_node)
      name = item_node.css(config.name_selector).text
      link = google_host + item_node["href"]
      image = images[index]
      extensions = item_node.css(config.extension_selector).map { |node| node.text.not_empty }.compact

      ExtractedItem.new(name: name, link: link, image: image, extensions: Array(extensions))
    end
  end

  private

  sig { returns(T::Boolean) }
  def has_carousel?
    !!@carousel_node
  end

  sig { params(doc: Nokogiri::HTML::Document).returns(T.nilable(T.class_of(BaseCarousel))) }
  def carousel_type_class(doc)
    SUPPORTED_CAROUSELS.find { |klass| klass.is_in? doc }
  end
end
