require 'forwardable'

module Parsers
  class KnowledgeGraph
    extend Forwardable

    CAROUSEL_SELECTOR     = 'g-scrolling-carousel'.freeze
    CAROUSEL_KEY_SELECTOR = 'Wkr6U z4P7Tc'.freeze
    LEGACY_CAROUSEL_KEY_SELECTOR = "//*[@id='kxbccs']".freeze

    def initialize(parsed_html)
      @parsed_html = parsed_html
    end

    def data
      return @data if defined?(@data)

      @data = {}
      @data.merge!(summary_data)
      @data.merge!(carousel_items_key => carousel_data) if carousel_html.kind_of?(Nokogiri::XML::Element)
      @data
    end

    def summary_data
      @summary_data ||= Parsers::Summary.new(parsed_html).data
    end

    def carousel_data
      @carousel_data ||= Parsers::Carousel.new(carousel_html).data
    end

    private

    def_delegators :parsed_html, :xpath, :css

    attr_reader :parsed_html

    def carousel_html
      css(CAROUSEL_SELECTOR).first
    end

    def carousel_items_key
      key = css(CAROUSEL_KEY_SELECTOR).last || xpath(LEGACY_CAROUSEL_KEY_SELECTOR)
      return if key.nil?

      key.text.downcase.gsub(' ', '_').to_sym
    end
  end
end
