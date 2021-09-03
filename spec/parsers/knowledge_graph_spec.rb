require_relative '../../parsers/knowledge_graph'
require 'json'

describe Parsers::KnowledgeGraph do
  subject { described_class.new(parsed_html, version) }

  let(:version) { :old }
  let(:parsed_html) { Nokogiri::HTML(File.open(file_path)) }
  let(:file_path) { 'files/van-gogh-paintings.html' }

  describe '#data' do
    it 'returns a Hash with extructed data' do
      expect(subject.data).to be_kind_of(Hash)
      expect(subject.data[:title]).to eq('Vincent van Gogh')
      expect(subject.data[:artworks]).to be_an(Array)
    end
  end
end
