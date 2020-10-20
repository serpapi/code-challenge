# frozen_string_literal: true

require_relative 'script/art_works_parser.rb'

class Runner
  def self.run(path = 'files/van-gogh-paintings.html')
    ArtWorksParser.new(path).parse
  end
end
