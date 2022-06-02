require_relative '../GoogleAppBarExtractor'
require "test/unit"
require 'json'

class TestGoogleAppBarExtractor < Test::Unit::TestCase


  def setup
    @extractor = GoogleAppBarExtractor.new
  end


  def test_van_gogh_paintings

    results = @extractor.extract_cards(File.read(__dir__ + "/van-gogh-paintings.html"))
    expected_results = File.read(__dir__ + "/van-gogh-paintings-results.json")
    expected_results = JSON.parse(expected_results)

    results.each_with_index { |item, i|
      assert_equal(expected_results['knowledge_graph']['artworks'][i]['name'], item[:name])
      assert_equal(expected_results['knowledge_graph']['artworks'][i]['link'], item[:link])
      assert_equal(expected_results['knowledge_graph']['artworks'][i]['image'], item[:image])
      assert_equal(expected_results['knowledge_graph']['artworks'][i]['extensions'], item[:extensions])
    }
  end

  def test_best_action_movies
    results = @extractor.extract_cards(File.read(__dir__ + "/best-action-movies.html"))
    expected_results = File.read(__dir__ + "/best-action-movies-results.json")
    expected_results = JSON.parse(expected_results)

    results.each_with_index { |item, i|
       assert_equal(expected_results[i]['name'], item[:name])
       assert_equal(expected_results[i]['link'], item[:link])
       assert_equal(expected_results[i]['image'], item[:image])
       assert_equal(expected_results[i]['extensions'], item[:extensions])
    }
  end

  def test_mu_fc_players
    results = @extractor.extract_cards(File.read(__dir__ + "/mu-fc-players.html"))
    expected_results = File.read(__dir__ + "/mu-fc-players-results.json")
    expected_results = JSON.parse(expected_results)

    results.each_with_index { |item, i|
       assert_equal(expected_results[i]['name'], item[:name])
       assert_equal(expected_results[i]['link'], item[:link])
       assert_equal(expected_results[i]['image'], item[:image])
       assert_equal(expected_results[i]['extensions'], item[:extensions])
    }
  end

end