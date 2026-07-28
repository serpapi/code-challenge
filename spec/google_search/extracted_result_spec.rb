# frozen_string_literal: true

require 'json'
require_relative '../../lib/google_search/extracted_result'

RSpec.describe GoogleSearch::ExtractedResult do
  let(:attributes) do
    {
      name: 'The Starry Night',
      extensions: ['1889'],
      link: 'https://www.google.com/search?q=The+Starry+Night',
      image: 'data:image/jpeg;base64,abc123'
    }
  end

  describe '#to_h' do
    it 'includes all attributes when extensions are present' do
      expect(described_class.new(**attributes).to_h).to eq(attributes)
    end

    it 'omits the extensions key when extensions are nil' do
      result = described_class.new(**attributes, extensions: nil)

      expect(result.to_h).not_to have_key(:extensions)
    end

    it 'omits the extensions key when extensions are empty' do
      result = described_class.new(**attributes, extensions: [])

      expect(result.to_h).not_to have_key(:extensions)
    end

    it 'defaults extensions to nil' do
      result = described_class.new(**attributes.except(:extensions))

      expect(result.extensions).to be_nil
    end
  end

  describe '#to_json' do
    it 'serializes the hash representation' do
      expect(JSON.parse(described_class.new(**attributes).to_json)).to eq(
        'name' => 'The Starry Night',
        'extensions' => ['1889'],
        'link' => 'https://www.google.com/search?q=The+Starry+Night',
        'image' => 'data:image/jpeg;base64,abc123'
      )
    end
  end
end
