require "test/unit"
require 'byebug'
require 'nokogiri'
require_relative "../src/Carousel"

class TestCarousel < Test::Unit::TestCase

    def test_output
        # arrange
        json_file = File.read('files/expected-array.json');
        html_file = File.open('files/van-gogh-paintings.html');
        parsed_html = Nokogiri::HTML.parse(html_file);
        example_artworks = JSON.parse(json_file)['artworks'];

        # act
        carousel = Carousel.new(parsed_html.at('g-scrolling-carousel'));

        # assert
        assert_equal(example_artworks.length, carousel.artworks.length);
        carousel.artworks.each_with_index do |art,index|
            assert_equal(example_artworks[index]['name'], art[:name]);
            assert_equal(example_artworks[index]['extensions'], art[:extensions]);
            assert_equal(example_artworks[index]['link'], art[:link]);
            # assert_equal(example_artworks[index]['image'], art[:image]);
        end
    end
end
