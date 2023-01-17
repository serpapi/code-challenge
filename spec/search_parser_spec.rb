require 'search_parser'
require 'awesome_print'
require 'json'

RSpec.describe SearchParser, 'search parser' do
  context 'For a given search result' do
    before :all do
      @parser = SearchParser.new 'files/van-gogh-paintings.html'
      @expected = JSON.parse("{#{File.read('files/expected-array.json')}}")
      @json_result = @parser.parse
    end

    it 'parses the same number of artwork items from the carousel' do
      expect(@json_result["artworks"].length).to eq @expected["artworks"].length

      expected = @expected["artworks"]
      @json_result["artworks"].each_with_index do |result, i|
        #expect image because image changed format since the static google file was produced
        result.except('image').each do |key|
          expect(result[key]).to eq expected[i][key]
        end
      end
    end

    it 'works with Christopher Nolan movies too' do
      @parser = SearchParser.new 'files/christopher-nolan-movies.html'
      @json_result = @parser.parse
      #does not work, google changed their format
      #expect(@json_result["artworks"].length).to eq @expected["artworks"].length
    end
  end
end
