# frozen_string_literal: true

require 'nokogiri'

# Arac is a powerful, easy-to-use Ruby library for web scraping.
# This module provides a simple DSL for defining and extracting data from HTML documents.
#
# Example:
#   arac = Arac.new do
#     item :title, selector: "h1", methods: [[:text]]
#     item :author, selector: ".author", methods: [[:text]]
#   end
#
#   html = "<html><body><h1>My First Heading</h1><p class="author">John Doe</p></body></html>"
#   data = arac.capture_from(html)
#   puts data[:title]  # Outputs: "My First Heading"
#   puts data[:author] # Outputs: "John Doe"
#
module Arac
  class << self
    # Creates a new Extractor instance.
    #
    # @param block [Proc] Optional block that gets evaluated in the context of the new Extractor instance.
    # @return [Extractor] The newly created Extractor instance.
    def new(&block)
      Extractor.new(&block)
    end
  end

  # The Extractor class allows defining and extracting data from HTML documents.
  # It also supports nested item extraction and extraction of arrays of nested items.
  class Extractor
    class ExtractionError < StandardError; end

    # Initializes an extractor.
    #
    # @yield a block in the context of the current object, which is used to define the output
    #   specification
    def initialize(&block)
      @output_spec = {}
      instance_eval(&block) if block_given?
    end

    # Adds an item to the output spec.
    #
    # @param key [Symbol] the key to store the item under in the output.
    # @param selector [String] the CSS selector to use to find the item in the HTML.
    # @param methods [Array] an array of method and argument pairs to call on each matching node.
    def item(key, selector:, methods: [[:text]], &block)
      @output_spec[key] = {
        multiple: false,
        selector: selector,
        methods: methods,
        block: block
      }
    end

    # Adds a collection of items to the output spec.
    #
    # @param key [Symbol] the key to store the items under in the output.
    # @param selector [String] the CSS selector to use to find the items in the HTML.
    # @param methods [Array] an array of method and argument pairs to call on each matching node.
    def items(key, selector:, methods: [], &block)
      @output_spec[key] = {
        multiple: true,
        selector: selector,
        methods: methods,
        block: block
      }
    end

    # Extracts data from the HTML according to the output spec.
    #
    # @param html [String] the HTML document from which to extract the data.
    # @return [Hash] a hash of extracted items.
    # @raise [ExtractionError] if extraction fails.
    def capture_from(html)
      parser = Parser.new(html)
      output = {}

      begin
        # Iterate over each item in the output specification
        @output_spec.each do |key, spec|
          # Use the parser to extract nodes from the HTML using the selector in the spec
          nodes = parser.extract(spec[:selector])

          # If a block is present in the specification, then use it to extract nested data
          if spec[:block]
            # Create a new Extractor instance using the block from the specification
            nested_extractor = self.class.new(&spec[:block])

            # If multiple is set to true in the spec, then apply the extraction to all nodes
            output[key] = if spec[:multiple]
                            nodes.map { |node| nested_extractor.capture_from(node.to_html) }
                          else
                            # Otherwise, apply the extraction to only the first node
                            nested_extractor.capture_from(nodes.first.to_html)
                          end
          else
            # If no block is present in the specification, then apply the methods in the spec to the nodes

            # If multiple is set to true in the spec, then apply the methods to all nodes
            output[key] = if spec[:multiple]
                            nodes.map { |node| parser.apply_methods(node, spec[:methods]) }
                          else
                            # Otherwise, apply the methods to only the first node
                            parser.apply_methods(nodes.first, spec[:methods])
                          end
          end
        end
      rescue StandardError => e
        raise ExtractionError, "Error during extraction: #{e.message}"
      end

      output
    end
  end
end
