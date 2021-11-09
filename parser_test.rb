require 'minitest/autorun'
require './parser.rb'
require 'json'

class TestCase < Minitest::Test
  def test_van_gogh
    parser = Parser.new('./files/van-gogh-paintings.html',['g-scrolling-carousel a'])
    expected_array = JSON.parse(File.read('./files/expected-array.json'))
    assert_equal expected_array.length, parser.results.length
    (0..expected_array.length).each{ |i|
      assert_equal(expected_array[i],parser.results[i])
    }
    print('test finished')
  end

  def test_alex_grey
    parser = Parser.new('./files/alex-gray-paintings.html',['g-scrolling-carousel a'])
    expected_array = JSON.parse(File.read('./files/expected-array-alex-gray.json'))
    assert_equal expected_array.length, parser.results.length
    (0..expected_array.length).each{ |i|
      assert_equal(expected_array[i],parser.results[i])
    }
  end

  def test_picasso
    parser = Parser.new('./files/pablo-picasso-paintings.html',['g-scrolling-carousel a'])
    expected_array = JSON.parse(File.read('./files/expected-array-pablo-picasso.json'))
    assert_equal expected_array.length, parser.results.length
    (0..expected_array.length).each{ |i|
      assert_equal(expected_array[i],parser.results[i])
    }
    
  end
  
end
