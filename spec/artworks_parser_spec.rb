# frozen_string_literal: true

require 'spec_helper'
require 'artworks_parser'

describe ArtworksParser do
  let(:parser) { described_class.new }
  let(:html_page_path) { 'files/van-gogh-paintings.html' }
  let(:json_page_path) { 'files/van-gogh-paintings.json' }
  let(:json_element_path) { 'spec/fixtures/artworks_parser.json' }

  let(:page) { Nokogiri(File.open(html_page_path)) }
  let(:knowledge_graph) { JSON.parse(File.read(json_page_path)) }
  let(:element_hash) { JSON.parse(File.read(json_element_path)) }

  describe '#call' do
    let(:paintings) { knowledge_graph.dig('knowledge_graph', 'artworks') }
    subject { parser.call(page) }

    it { expect(subject.size).to eq(paintings.size) }
    it { expect(subject[0]).to eq(element_hash.fetch('result')) }

    context 'when banksy example' do
      let(:html_page_path) { 'spec/fixtures/banksy.html' }
      it 'skip extensions if no meta information' do
        expect(subject[0].key?('extensions')).to be_falsey
      end
      it 'extract extensions correctly' do
        expect(subject[1]['extensions']).to eq(['2002'])
      end

      it 'extract image too' do
        expect(subject[-1]['image']).to eq(element_hash['banksy_image'])
      end

      it { expect(subject.size).to eq(32) }
    end

    context 'when claude mone example' do
      let(:html_page_path) { 'spec/fixtures/claude-mone.html' }
      it 'skip extensions if no meta information' do
        expect(subject[0].key?('extensions')).to be_truthy
      end
      it 'extract extensions correctly' do
        expect(subject[1]['extensions']).to eq(['1900'])
      end

      it 'extract image too' do
        expect(subject[-1]['image']).to eq(element_hash['cloude_mone_image'])
      end

      it { expect(subject.size).to eq(51) }
    end
  end
end
