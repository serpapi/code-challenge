# typed: strict
# frozen_string_literal: true

require "sorbet-runtime"
require "./src/carousels/carousel_config"

class BaseCarousel
  extend T::Sig
  extend T::Helpers
  abstract!

  sig { params(doc: Nokogiri::HTML::Document).returns(T::Boolean) }
  def self.is_in?(doc)
    doc.css(config.detect_selector).any?
  end

  sig { abstract.returns(CarouselConfig) }
  def self.config
  end

  sig { params(html: String, doc: Nokogiri::HTML::Document).void }
  def initialize(html, doc)
  end

  sig { params(item_node: Nokogiri::XML::Node).returns(Nokogiri::XML::Node) }
  def transform_item_node(item_node)
    item_node
  end
end
