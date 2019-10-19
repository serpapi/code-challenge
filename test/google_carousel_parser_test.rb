require File.expand_path '../../google_carousel_parser.rb', __FILE__
require 'minitest/autorun'
require 'json'

class GoogleCarouselParserTest < Minitest::Test
  def test_joaquin_input
    parser = GoogleCarouselParser.new('./test/page_examples/joaquin-phoenix-movies-list.html')
    assert_equal File.read('./test/json_examples/joaquin-phoenix-movies-list.json'), parser.result.to_json
  end

  def test_gogh_input
    parser = GoogleCarouselParser.new('./test/page_examples/van-gogh-paintings.html')
    assert_equal File.read('./test/json_examples/van-gogh-paintings.json'), parser.result.to_json
  end

  def test_aal_input
    parser = GoogleCarouselParser.new('./test/page_examples/animals-as-leaders-albums.html')
    assert_equal File.read('./test/json_examples/animals-as-leaders-albums.json'), parser.result.to_json
  end
end

