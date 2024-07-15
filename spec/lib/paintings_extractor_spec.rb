require 'spec_helper'
require 'json'

RSpec.describe PaintingsExtractor do
  describe '#extract_paintings' do
    subject { described_class.new(html_file_path).extract_paintings }

    context 'when parsing a file with a single painting' do
      let(:html_file_path) { 'spec/fixtures/van-gogh-painting.html' }
      let(:expected_output) { JSON.parse(File.read('spec/fixtures/single-painting-expected-array.json'))['artworks'] }

      it 'extracts paintings correctly' do
        expect(subject.first['name']).to eq expected_output.first['name']
        expect(subject.first['extensions']).to eq expected_output.first['extensions']
        expect(subject.first['link']).to eq expected_output.first['link']
        expect(subject.first['image']).to eq expected_output.first['image']
      end
    end

    context 'when parsing a file with multiple paintings' do
      let(:html_file_path) { 'spec/fixtures/van-gogh-paintings.html' }
      let(:expected_output) { JSON.parse(File.read('spec/fixtures/expected-array.json'))['artworks'] }

      it 'extracts paintings correctly' do
        is_expected.to eq expected_output
      end
    end
  end
end