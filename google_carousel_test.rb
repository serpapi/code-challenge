require 'minitest/autorun'
require './google_carousel.rb'
require 'json'

class TestMeme < Minitest::Test
  def test_van_goph_paintings_with_expected_array
    expected_array = GoogleCarousel.parse_html(File.read('files/van-gogh-paintings.html'))
    given_array = JSON.parse(File.read('files/expected-array.json'))

    assert_arrays_equal(expected_array, given_array)
  end

  def test_pablo_picasso
    expected_array = GoogleCarousel.parse_html(File.read('files/pablo-picasso-paintings.html'))
    given_array = JSON.parse(File.read('files/expected-array-pablo-picasso.json'))

    assert_arrays_equal(expected_array, given_array)
  end

  def test_alex_gray
    expected_array = GoogleCarousel.parse_html(File.read('files/alex-gray-paintings.html'))
    given_array = JSON.parse(File.read('files/expected-array-alex-gray.json'))

    assert_arrays_equal(expected_array, given_array)
  end

  def assert_arrays_equal(expected_array, given_array)
    assert_equal expected_array.length, given_array.length
    expected_array.each_with_index do |item, i|
      assert_equal item, given_array[i]
    end
  end
end
