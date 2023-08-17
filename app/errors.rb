# frozen_string_literal: true

module Errors
  PageAdapterNotFound = Class.new(StandardError)
  ParserNotFound = Class.new(StandardError)
  FileNotFound = Class.new(StandardError)

  class ParseError < StandardError
  end
end
