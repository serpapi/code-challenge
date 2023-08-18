# frozen_string_literal: true

require 'spec_helper'
require 'json'

describe Parser::Google::ImageCarousel do
  let(:html) do
    File.open('./files/van-gogh-paintings.html')
  end
  let(:expected_result) do
    JSON.parse(File.read('./files/expected-array.json'), symbolize_names: true)
  end
  let(:parser) { described_class.new html }

  describe '#to_hash' do
    it 'returns parsed json for given page' do
      expect(parser.to_hash).to eq(expected_result)
    end
  end
end
