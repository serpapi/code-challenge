# frozen_string_literal: true

require 'nokogiri'

module Arac
  # The Parser class handles the parsing of HTML and the extraction of elements from the parsed HTML document.
  # It uses the Nokogiri library to parse the HTML and find elements matching provided CSS selectors.
  #
  # Example:
  #
  #   html = "<h1>Hello, world!</h1>"
  #   parser = Arac::Parser.new(html)
  #   headings = parser.extract("h1", [["text"]])
  #   puts headings # Output: ["Hello, world!"]
  #
  class Parser
    # Initializes a Parser instance with the HTML content to be parsed.
    #
    # @param html [String] the HTML content to be parsed.
    # @param encoding [String] the character encoding of the HTML content.
    # @param options [Fixnum] bitwise options for the parser.
    def initialize(html)
      # TODO(celicoo): detect encoding
      @doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    end

    # Extracts nodes from the HTML document that match the given CSS selector.
    #
    # @param selector [String] a CSS selector.
    # @return [Nokogiri::XML::NodeSet] a set of nodes that match the selector.
    def extract(selector)
      @doc.css(selector)
    end

    # Applies an array of methods to a node.
    #
    # @param node [Nokogiri::XML::Node] the node to which the methods should be applied.
    # @param methods [Array] an array of method and argument pairs.
    # @return [Object] the result of applying the methods to the node.
    # @raise [NoMethodError] if the node does not respond to the given method.
    def apply_methods(node, methods)
      methods.reduce(node) do |current_node, (method, *args)|
        return nil if current_node.nil?

        unless current_node.respond_to?(method)
          raise NoMethodError,
                "The method '#{method}' does not exist for #{current_node.class}"
        end

        current_node.public_send(method, *args)
      end
    end
  end
end
