require './files/scraper'
require 'rspec'

describe 'Scraper' do
  describe '.parse_appbar_from' do
    let!(:expected) do
      JSON.parse(File.read('./files/expected-array.json'), symbolize_names: true)[:artworks].sort_by { |h| h[:name] }
    end
    let!(:array) { JSON.parse(Scraper.parse_appbar_from, symbolize_names: true).sort_by { |h| h[:name] } }

    it 'parses the correct number of items' do
      expect(array.size).to be(expected.size)
    end

    it 'parses the expected names' do
      array.each_with_index { |item, i| expect(item[:name]).to eql(expected[i][:name]) }
    end

    it 'parses the expected extensions' do
      array.each_with_index { |item, i| expect(item[:extensions]).to eql(expected[i][:extensions]) }
    end

    it 'parses the expected links' do
      array.each_with_index { |item, i| expect(item[:link]).to eql(expected[i][:link]) }
    end

    it 'parses base64 strings if available' do
      array.each do |item|
        expect(item[:thumbnail]).to match(/data:image/) if !item[:thumbnail].nil?
      end
    end
  end
end
