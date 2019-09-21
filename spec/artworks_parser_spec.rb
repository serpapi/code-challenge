# frozen_string_literal: true

require 'spec_helper'
require 'artworks_parser'

describe ArtworksParser do
  let(:parser) { described_class.new }
  let(:html_page_path) { 'files/van-gogh-paintings.html' }
  let(:json_page_path) { 'files/van-gogh-paintings.json' }

  let(:page) { Nokogiri(File.open(html_page_path)) }
  let(:knowledge_graph) { JSON.parse(File.read(json_page_path)) }


  xdescribe '#extract_paitings' do
    let(:paintings) { knowledge_graph.dig('knowledge_graph', 'artworks') }
    subject { parser.extract_paitings(page) }

    it { is_expected.to match_array(paintings) }
    it { expect(subject.size).to eq(paintings.size) }
  end

  describe '#extract_paiting' do
    let(:json_element_path) { 'spec/fixtures/artwork_parser.json' }
    let(:element_hash) { JSON.parse(File.read(json_element_path)) }
    let(:nokogiri_obj) { Nokogiri(element_hash.fetch('element')).css('a')[0] }
    let(:result) { element_hash.fetch('result') }
    subject { parser.extract_paiting(nokogiri_obj) }

    it { is_expected.to eq(result) }
  end
end
