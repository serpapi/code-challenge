require_relative 'GoogleAppBarExtractor'
require "test/unit"

class TestSimpleNumber < Test::Unit::TestCase


  def setup
    @extractor = GoogleAppBarExtractor.new
    @results = @extractor.extractCards(File.read(__dir__ + "/../files/van-gogh-paintings.html"))
  end

  def test_cards_count_should_be_51
    assert_equal(51, @results.size)
  end

  def test_first_card_name
    assert_equal('The Starry Night', @results[0][:name])
  end

  def test_last_card_name
    assert_equal('Portrait of Adeline Ravoux', @results[50][:name])
  end

end