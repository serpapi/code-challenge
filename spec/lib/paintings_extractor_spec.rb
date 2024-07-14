require 'spec_helper'

RSpec.describe PaintingsExtractor do
  describe '#extract_paintings' do
    subject { described_class.new(html).extract_paintings }

    let(:html) { File.read('spec/fixtures/van-gogh-paintings.html') }

    it 'extracts paintings correctly' do
      is_expected.not_to be_empty
      expect(subject.first).to include(:image, :link, :name, :extensions)
    end
  end
end