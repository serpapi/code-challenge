# frozen_string_literal: true

require 'json'
require_relative './../challenge/challenge'

describe 'Van Gogh Artwork' do
  before :all do
    file_path = File.expand_path('files/van-gogh-paintings.html')
    document = Challenge::HtmlFileParser.new(file_path).parse
    @results = Challenge::Parser.new(document).parse
  end

  describe 'Artwork Item' do
    before(:all) do
      @item = @results.first
    end

    it 'has a name' do
      expect(@item[:name]).to eql('The Starry Night')
    end

    it 'has an image' do
      expect(@item[:image]).to match(%r{^data:image/jpeg;base64})
    end

    it 'has link' do
      expect(@item[:link]).to match(%r{^https://www.google.com/search?})
    end

    it 'has extensions' do
      expect(@item[:extensions]).to be_an(Array)
    end

    context 'when there is no date on item' do
      before { @item = @results[2] }

      it 'does not have extensions' do
        expect(@item).not_to have_key(:extensions)
      end
    end

    context 'when thumbnail is not provided' do
      before { @item = @results.last }

      it 'has image set to nil' do
        expect(@item).to have_key(:image)
        expect(@item[:image]).to be_nil
      end
    end
  end

  describe 'Arwork Collection' do
    before :all do
      @expected_array = expected_array
    end
    it 'has an entry for all items' do
      expect(@results.size).to equal(expected_array.size)
    end

    it 'should match expected array' do
      # A few links are problematic with respect to escaped characters.
      # For example a single quote(') character might be unesca character (as in At+Eternity's+Gate)
      # Either way the link is still valid
      # For that reason, we choose to unescape links before performing a comparison
      expect(@results.tap { |r| unescape_links(r) }).to eql(expected_array.tap { |r| unescape_links(r) })
    end
  end
end

def expected_array
  content = File.read('files/expected-array.json')
  JSON.parse(content, symbolize_names: true)[:artworks]
end

def unescape_links(items)
  items.map do |item|
    item[:link] = CGI.unescape(item[:link])
  end
end
