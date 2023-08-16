# frozen_string_literal: true

require 'services/carousel_parser'
require 'json'
require 'watir'

describe Services::CarouselParser do
  before :all do
    @browser = Watir::Browser.new :chrome, headless: true
  end
  describe :original_challenge do
    before :all do
      @browser.goto("file://#{File.dirname(__FILE__)}/../files/van-gogh-paintings.html")
      @parsed_carousel = Services::CarouselParser.call(@browser.html)
      expected_file = File.open('files/expected-array.json')
      @expected = JSON.parse("{ #{expected_file.read} } ")['artworks']
    end

    %w[name link year].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |artwork| artwork[expected_test_attribute] }
        actual = @parsed_carousel.map { |artwork| artwork[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end

  describe :other_document do
    before :all do
      @browser.goto("file://#{File.dirname(__FILE__)}/../files/queen-song-writers.html")
      @parsed_carousel = Services::CarouselParser.call(@browser.html)
      expected_file = File.open('files/expected-artists.json')
      @expected = JSON.parse("{ #{expected_file.read} } ")['artists']
    end

    %w[name link image].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |artist| artist[expected_test_attribute] }
        actual = @parsed_carousel.map { |artist| artist[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end
end
