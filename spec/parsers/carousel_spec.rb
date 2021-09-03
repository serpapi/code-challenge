require_relative '../../parsers/carousel'
require 'json'

describe Parsers::Carousel do
  subject { described_class.new(carousel_html, version) }

  let(:version) { :old }
  let(:carousel_html) { Parsers::KnowledgeGraph.new(parsed_html, version).carousel_html }
  let(:parsed_html) { Nokogiri::HTML(File.open(file_path)) }
  let(:file_path) { 'files/van-gogh-paintings.html' }

  describe '#data' do
    it 'returns an Array of Hash elements' do
      expect(subject.data).to be_kind_of(Array)
      expect(subject.data.first).to be_kind_of(Hash)
    end
  end
end
