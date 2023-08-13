require_relative './app/app.rb'

raw_filepath = './files/van-gogh-paintings.html'
json_filepath = './files/expected-array.json'

raw = File.read(raw_filepath)
parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call
result = Scrapers::GoogleCarousel20190319.new(raw:, parsed:).call

RSpec.describe 'Scraper' do
  expected_result = JSON.parse(File.read(json_filepath), symbolize_names: true)
  expected_result[:artworks].each_with_index do |artwork, index|
    context "for artwork at index #{index}" do
      artwork.each_pair do |key, value|
        it "matches the #{key}" do
          expect(result[:artworks][index][key]).to eq(value)
        end
      end
    end
  end
end