# frozen_string_literal: true

require 'nokolexbor'

module PageApi
  class Nokolexbor
    attr_reader :data

    def initialize(data)
      @page = ::Nokolexbor::HTML(data)
    end

    # NOTE: this is simplified interface

    def css(selector)
      @page.css(selector)
    end
  end
end
