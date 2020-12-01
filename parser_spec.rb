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

    it "should contain 51 artworks" do
      _(JSON.parse(@parser.create)['artworks'].size).must_equal 51
    end

    it "should create a extensions field when a year is present" do
      w = JSON.parse(@parser.create)['artworks'][0]
      _(w['name']).must_equal "The Starry Night"
      _(w).include?('extensions')
    end

    it "should not create a extensions field when there's no year" do
      w = JSON.parse(@parser.create)['artworks'][2]
      _(w['name']).must_equal "Sunflowers"
      _(w).wont_include('extensions')
    end

    it "should create a file called output.json" do
      @parser.create
      file = File.open('./output.json')
      json = JSON.parse(file.read)
      _(json['artworks'].size).must_equal 51
    end
  end
end
