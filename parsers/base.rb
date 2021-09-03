require 'forwardable'

module Parsers
  class Base
    extend Forwardable

    def initialize(parsed_html, version)
      @parsed_html = parsed_html
      @version = version
    end

    def data
      return @data if defined?(@data)

      @data = attribute_names.each_with_object({}) do |attribute_name, hash|
        hash[attribute_name] = self.public_send(attribute_name)
      end

      @data
    end

    private

    attr_reader :parsed_html, :version

    def_delegators :parsed_html, :xpath, :css
    def_delegators :attributes, :attribute_names, :extract_value

    def attributes
      @attributes ||= Attributes.new(self.class.name, parsed_html, version)
    end
  end
end
