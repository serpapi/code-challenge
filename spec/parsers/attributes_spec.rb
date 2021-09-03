require_relative '../../parsers/attributes'
require 'json'

describe Parsers::Attributes do
  subject { described_class.new('Parsers::KnowledgeGraph', parsed_html, version) }

  let(:parsed_html) { Nokogiri::HTML(File.open(file_path)) }
  let(:version) { :old }
  let(:file_path) { 'files/van-gogh-paintings.html' }

  describe '#attribute_names' do
    it 'returns an Array attribute names' do
      expect(subject.attribute_names).to eq(%i[carousel_items_key carousel_html])
    end
  end

  describe '#attribute' do
    it 'returns an attribute' do
      expect(subject.attribute(:carousel_items_key)).to eq(type: 'xpath', value: "//*[@id='kxbccs']")
    end
  end

  describe '#extract_value' do
    it 'returns an attribute value' do
      expect(subject.extract_value(:carousel_items_key)).to be_truthy
      expect(subject.extract_value(:carousel_items_key)).to be_kind_of(Nokogiri::XML::NodeSet)
      expect(subject.extract_value(:carousel_items_key).first).to be_kind_of(Nokogiri::XML::Element)
    end
  end
end
