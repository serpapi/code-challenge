# frozen_string_literal: true

require 'services/carousel_parser'
require 'json'

describe Services::CarouselParser do
  describe :original_challenge do
    before :all do
      @expected, @actual = load_data('van-gogh-paintings.html', 'expected-array.json', 'artworks')
    end

    %w[name link year].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |artwork| artwork[expected_test_attribute] }
        actual = @actual.map { |artwork| artwork[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end

  describe :queen_song_writers do
    before :all do
      @expected, @actual = load_data('queen-song-writers.html', 'expected-artists.json', 'artists')
    end

    %w[name link image].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |artist| artist[expected_test_attribute] }
        actual = @actual.map { |artist| artist[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end

  describe :buildings_in_bonn do
    before :all do
      @expected, @actual = load_data('buildings-in-bonn.html', 'expected-buildings.json', 'buildings')
    end

    %w[name link image].each do |expected_test_attribute|
      it "gets the correct #{expected_test_attribute}s" do
        expected = @expected.map { |building| building[expected_test_attribute] }
        actual = @actual.map { |building| building[expected_test_attribute] }
        expect(expected).to eq(actual)
      end
    end
  end

  def load_data(html, json, root_node_name)
    file_content = File.read("files/#{html}")
    actual = Services::CarouselParser.call(file_content, root_node_name)[root_node_name]
    expected_file = File.open("files/#{json}")
    expected = JSON.parse(expected_file.read)[root_node_name]

    [expected, actual]
  end
end
