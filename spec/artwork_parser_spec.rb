# frozen_string_literal: true

require 'spec_helper'
require 'artwork_parser'

describe ArtworkParser do
  let(:json_element_path) { 'spec/fixtures/artwork_parser.json' }
  let(:element_hash) { JSON.parse(File.read(json_element_path)) }

  describe '#call' do
    let(:nokogiri_obj) { Nokogiri(element_hash.fetch('element')).css('a')[0] }
    let(:result) { element_hash.fetch('result') }
    subject { described_class.new(nokogiri_obj).call }

    it { is_expected.to eq(result) }
  end
end
