require_relative './base.rb'

module Parsers
  class Summary < Parsers::Base
    def title
      extract_value(:title).text
    end
  end
end
