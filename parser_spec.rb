require "minitest/autorun"
require 'json'
require "./parser.rb"

describe Parser do
  before do
    @parser = Parser.new
  end

  describe "when running without arguments" do
    it "should return json output from the local file" do
      (JSON.parse(@parser.create)).include?('artworks')
    end
  end
end
