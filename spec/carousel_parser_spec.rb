# frozen_string_literal: true

require 'services/carousel_parser'
require 'json'

describe Services::CarouselParser do
  describe :original_challenge do
    before :all do
      file_content = File.read("#{Dir.pwd}/files/van-gogh-paintings.html")
      @parsed_carousel = Services::CarouselParser.call(file_content, 'artworks')['artworks']
      expected_file = File.open('files/expected-array.json')
      @expected = JSON.parse(expected_file.read)['artworks']
    end

    %w[name link year].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |artwork| artwork[expected_test_attribute] }
        actual = @parsed_carousel.map { |artwork| artwork[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end

  describe :queen_song_writers do
    before :all do
      file_content = File.read("#{Dir.pwd}/files/queen-song-writers.html")
      @parsed_carousel = Services::CarouselParser.call(file_content, 'artists')['artists']
      expected_file = File.open('files/expected-artists.json')
      @expected = JSON.parse(expected_file.read)['artists']
    end

    %w[name link image].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |artist| artist[expected_test_attribute] }
        actual = @parsed_carousel.map { |artist| artist[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end

  describe :buildings_in_bonn do
    before :all do
      file_content = File.read("#{Dir.pwd}/files/buildings-in-bonn.html")
      @parsed_carousel = Services::CarouselParser.call(file_content, 'buildings')['buildings']
      expected_file = File.open('files/expected-buildings.json')
      @expected = JSON.parse(expected_file.read)['buildings']
    end

    %w[name link image].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |building| building[expected_test_attribute] }
        actual = @parsed_carousel.map { |building| building[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end
end
