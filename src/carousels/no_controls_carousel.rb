# typed: strict
# frozen_string_literal: true

require "./src/carousels/base_carousel"
require "./src/carousels/carousel_config"

class NoControlsCarousel < BaseCarousel
  CONFIG = T.let(CarouselConfig.new(
    detect_selector: ".b5DzIe + g-scrolling-carousel",
    item_selector: "a[jscontroller]",
    name_selector: ".wfg6Pb",
    extension_selector: ".P2m1Af"
  ), CarouselConfig)

  ITEM_PATTERN = /window\.jsl\.dh\('(\w+)','(.+?)'/

  ItemCacheType = T.type_alias { T::Hash[String, String] }

  sig { override.returns(CarouselConfig) }
  def self.config
    CONFIG
  end

  sig { params(html: String, doc: Nokogiri::HTML::Document).void }
  def initialize(html, doc)
    @item_cache = T.let(extract_items_from_js(html), ItemCacheType)
  end

  sig { override.params(item_node: Nokogiri::XML::Node).returns(Nokogiri::XML::Node) }
  def transform_item_node(item_node)
    node_id = item_node["id"]
    return item_node unless node_id

    children_html = decode_hex_html T.must(@item_cache[node_id])
    item_node.children = children_html
    item_node
  end

  private

  # required for carousels without a sorting/filtering option, where the html source has the first 10-15 items, and the rest are embedded in js.
  sig { params(html: String).returns(ItemCacheType) }
  def extract_items_from_js(html)
    html.scan(ITEM_PATTERN).to_h
  end

  sig { params(str: String).returns(String) }
  def decode_hex_html(str)
    str.gsub(/\\x(..)/) { |s| $1.to_i(16).chr }
  end
end
