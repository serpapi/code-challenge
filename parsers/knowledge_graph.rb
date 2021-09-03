require_relative './base.rb'

module Parsers
  class KnowledgeGraph < Parsers::Base
    def data
      super

      @data.merge!(summary_data)
      @data.merge!(carousel_items_key => carousel_data) if carousel_html.kind_of?(Nokogiri::XML::Element)
      @data
    end

    def summary_data
      @summary_data ||= Parsers::Summary.new(parsed_html, version).data
    end

    def carousel_data
      @carousel_data ||= Parsers::Carousel.new(carousel_html, version).data
    end

    def carousel_items_key
      Array(extract_value(:carousel_items_key)).last&.text&.downcase&.gsub(' ', '_')&.to_sym
    end

    def carousel_html
      extract_value(:carousel_html).first
    end
  end
end
