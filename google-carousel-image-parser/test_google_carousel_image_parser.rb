# frozen_string_literal: true

require_relative 'google_carousel_image_parser'
require 'test/unit'
require 'json'

class TestGoogleCarouselImageParser < Test::Unit::TestCase

  def test_compare_data
    # Separating these into separate test methods costs time because initiating a Capybara session is slow
    # We can either create one Capybara session and pass them down into the parser class
    # Or make the class threadsafe and execute tests like so:
    [
      Thread.new { compare_data('famous-athletes') },
      Thread.new { compare_data('landscape-paintings') },
      Thread.new { compare_data('van-gogh-paintings', sanitize_image_src: true) }
    ].each(&:join)
  end

  def compare_data(search_query, sanitize_image_src: false)
    files_directory = File.expand_path('files', File.dirname(__dir__))

    html_file_path = File.join(files_directory, 'search-results', "#{search_query}.html")
    results = GoogleCarouselImageParser.new(absolute_file_path: html_file_path).parse

    results_by_name = {}
    results.each do |result|
      name = result['name']
      results_by_name[name] = result
    end

    json_file_path = File.join(files_directory, 'expected-array', "#{search_query}.json")
    expected_results = JSON.parse(File.read(json_file_path)).first.last
    expected_results.each do |expected_result|
      name = expected_result['name']
      failure_message = "#{search_query}: Failed test for name: #{name}"

      assert(results_by_name.has_key?(name), failure_message)

      actual_result = results_by_name[name]
      assert_equal(expected_result['extensions'], actual_result['extensions'], failure_message)
      assert_equal(expected_result['link'], actual_result['link'], failure_message)
      if expected_result['image'].nil? || !sanitize_image_src
        assert_equal(expected_result['image'], actual_result['image'], failure_message)
      else
        assert_equal(sanitize_image_src(expected_result['image']), actual_result['image'], failure_message)
      end
    end
  end

  def sanitize_image_src(src)
    # This is being done only for the original Van Gogh test expectation.
    # My guess is that the test data was created with a browser / JS library
    # that didn't escape characters well. So we get x3d instead of equal sign.
    # I've opened the page in both Firefox and Chrome - these last characters
    # should either be `=` or `==` - the traditional base64 padding characters,
    # not their hex equivalent
    src.sub(/x3dx3d\z/, '==').sub(/x3d\z/, '=')
  end

end
