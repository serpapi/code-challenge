# encoding: UTF-8

require 'json'
require "minitest/autorun"
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/integer/inflections'

require_relative '../lib/google_image_search'

class GoogleImageSearchTest < Minitest::Test
  def setup
    @scenarios = [
      {
        search_keyword: 'Van Gogh paintings',
        expectation: JSON.parse(File.open(File.join(__dir__, '../files/expected-array.json'), "r:UTF-8", &:read))
      }
    ]
  end

  def test_result_length_should_match_provided_array_length
    @scenarios.each do |scenario|
      assert_equal scenario[:expectation].with_indifferent_access[:artworks].length, GoogleImageSearch.search(q: scenario[:search_keyword]).with_indifferent_access[:artworks].length
    end
  end

  # HEY SerpApi, your expected array 9th item is wrong, I can see an image for "The Yellow House", and so are the next items right after
  def test_result_content_should_match_provided_array_content
    @scenarios.each do |scenario|
      expectation = scenario[:expectation].with_indifferent_access[:artworks]
      result = GoogleImageSearch.search(q: scenario[:search_keyword]).with_indifferent_access[:artworks]

      0.upto(expectation.length - 1) do |index|
        assert_equal expectation[index], result[index], "unexpected result at #{(index+1).ordinalize} thumbnail"
      end
    end
  end
end
