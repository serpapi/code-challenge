require 'spec_helper'
require 'json'
require_relative '../lib/parsers/klitem_parser'

describe 'CarouselParser' do
  describe 'KlitemParser' do
    before :all do
      @html = File.read(File.join(__dir__, '../files/van-gogh-paintings.html'))
      @parser = KlitemParser.new(@html)
      @parsed = @parser.parse
      @expected_json = File.read(File.join(__dir__, './expected-van-gogh-paintings.json'))
    end

    it 'Returns valid parsed data' do
      expect(@parsed).to eq(@expected_json)
      expect(@parsed).not_to be_empty
    end

    it 'contains valid name key and value' do
    end
  end
end
