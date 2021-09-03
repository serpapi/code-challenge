require_relative '../../parsers/summary'
require 'json'

describe Parsers::Summary do
  subject { described_class.new(parsed_html, version) }

  let(:version) { :old }
  let(:parsed_html) { Nokogiri::HTML(File.open(file_path)) }
  let(:file_path) { 'files/van-gogh-paintings.html' }

  describe '#data' do
    it 'returns a Hash with extructed data' do
      expect(subject.data).to be_kind_of(Hash)
      expect(subject.data).to eq({ title: 'Vincent van Gogh'})
    end
  end
end
