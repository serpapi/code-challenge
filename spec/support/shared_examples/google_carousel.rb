# frozen_string_literal: true

# This is a rather non-standard approach to generating specs yet very fast and thorough.
RSpec.shared_examples 'Google Carousel' do |raw_filepath, json_filepath|
  expected_result = JSON.parse(File.read(json_filepath), symbolize_names: true)
  heading = expected_result.keys.first

  before(:all) do
    raw = File.read(raw_filepath)
    parsed = Parsers::NokogiriHtmlParser.new(filepath: raw_filepath).call
    @result = described_class.new(raw:, parsed:).call
  end

  it 'is exactly the same' do
    expect(@result).to eq(expected_result)
  end

  it 'has the same heading' do
    expect(@result.keys.first).to eq(heading)
  end

  expected_result[heading].each_with_index do |item, index|
    context "for item at index #{index}" do
      item.each_pair do |key, value|
        it "matches the #{key}" do
          expect(@result[heading][index][key]).to eq(value)
        end
      end
    end
  end
end
