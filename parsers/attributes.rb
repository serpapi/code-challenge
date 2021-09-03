require 'forwardable'
require 'yaml'

module Parsers
  class Attributes
    extend Forwardable

    CONFIG_FILE_PATH = 'config/selectors.yml'.freeze

    def initialize(class_name, parsed_html, version)
      @class_name = class_name
      @parsed_html = parsed_html
      @version = version
    end

    def attribute_names
      Hash(attributes).keys
    end

    def attribute(attribute_name)
      attributes[attribute_name]
    end

    def extract_value(attribute_name)
      attribute = attributes[attribute_name]

      raise StandardError, "Selector config for #{ class_name }##{ attribute_name } not found" if attribute.nil?

      self.public_send(attribute[:type], *Array(attribute[:value]))
    end

    private

    attr_reader :class_name, :parsed_html, :version

    def_delegators :parsed_html, :xpath, :css

    def attributes
      @attributes ||= YAML.load_file(CONFIG_FILE_PATH)[:versions][version][class_name]
    end
  end
end
