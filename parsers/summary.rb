require 'forwardable'

module Parsers
  class Summary
    extend Forwardable

    TITLE_SELECTOR = "//h2[@data-attrid='title']".freeze
    LEGACY_TITLE_SELECTOR = "//*[@class='kno-ecr-pt kno-fb-ctx gsmt sKbx2c']//span".freeze

    def initialize(parsed_html)
      @parsed_html = parsed_html
    end

    def data
      {
        title: title
      }
    end

    def title
      xpath(TITLE_SELECTOR).any? ? xpath(TITLE_SELECTOR).text : xpath(LEGACY_TITLE_SELECTOR)&.text
    end

    private

    attr_reader :parsed_html

    def_delegators :parsed_html, :xpath
  end
end
