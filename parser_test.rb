require 'minitest/autorun'
require './parser.rb'
require 'json'

class TestCase < Minitest::Test
  def test_equivalence
    parser = Parser.new('./files/van-gogh-paintings.html',['g-scrolling-carousel.arDHIe a','g-scrolling-carousel a'])
    expected_array = JSON.parse(File.read('./files/expected-array.json'))
    assert_equal expected_array.length, parser.results.length
    (0..expected_array.length).each{ |i|
      assert_equal(expected_array[i],parser.results[i])
    }
    print('test finished')
  end
  
end
