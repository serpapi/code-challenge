require './crawler.rb'
require "test/unit"
require 'json'

class ArtCrawlerTest < Test::Unit::TestCase
    def setup
        @sample_file = File.open("files/van-gogh-paintings.html")
        @crawler = ArtCrawler.new(@sample_file&.read)

        expected_array_file = File.open("files/expected-array.json")
        expected_array_data = expected_array_file&.read
        expected_array_complete = JSON.parse(expected_array_data)
        @expected_array = expected_array_complete['artworks']
    end

    def test_local_art_crawler
        @crawler.run().each_with_index do |row, id|
            assert_equal(@expected_array[id], row)
        end
    end
end
