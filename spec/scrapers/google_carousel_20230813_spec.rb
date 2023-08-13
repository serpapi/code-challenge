# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Scrapers::GoogleCarousel20230813 do
  context 'Jan Matejko paintings' do
    raw_filepath = './files/jan-matejko-paintings.html'
    json_filepath = './files/expected-array-updated-matejko.json'
    expected_result = JSON.parse(File.read(json_filepath), symbolize_names: true)
    heading = expected_result.keys.first

    before(:all) do
      raw = File.read(raw_filepath)
      parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call
      @result = described_class.new(raw:, parsed:).call
    end

    it 'has the same heading' do
      expect(@result.keys.first).to eq(heading)
    end

    expected_result[heading].each_with_index do |artwork, index|
      context "for artwork at index #{index}" do
        artwork.each_pair do |key, value|
          it "matches the #{key}" do
            expect(@result[heading][index][key]).to eq(value)
          end
        end
      end
    end
  end

  context 'Claude Monet paintings' do
    raw_filepath = './files/claude-monet-paintings.html'
    json_filepath = './files/expected-array-updated-monet.json'
    expected_result = JSON.parse(File.read(json_filepath), symbolize_names: true)
    heading = expected_result.keys.first

    before(:all) do
      raw = File.read(raw_filepath)
      parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call
      @result = described_class.new(raw:, parsed:).call
    end

    it 'has the same heading' do
      expect(@result.keys.first).to eq(heading)
    end

    expected_result[heading].each_with_index do |artwork, index|
      context "for artwork at index #{index}" do
        artwork.each_pair do |key, value|
          it "matches the #{key}" do
            expect(@result[heading][index][key]).to eq(value)
          end
        end
      end
    end
  end
end
