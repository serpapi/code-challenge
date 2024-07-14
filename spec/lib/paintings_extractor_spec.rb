require 'spec_helper'
require 'json'

RSpec.describe PaintingsExtractor do
  describe '#extract_paintings' do
    subject { described_class.new(html).extract_paintings }

    let(:html) { File.read('spec/fixtures/van-gogh-paintings.html') }
    let(:expected_array) { JSON.parse(File.read('spec/fixtures/expected-array.json'))['artworks'] }

    it 'extracts paintings correctly' do
      is_expected.not_to be_empty

      expect(subject).to eq(expected_array)
    end
  end
end