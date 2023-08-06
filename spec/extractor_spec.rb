# frozen_string_literal: true

require 'nokogiri'
require_relative '../app/extractor'

RSpec.describe Extractor do
  let(:object) { described_class.new('spec/files/test_input.html') }

  it 'returns correct json data' do
    expected_result = {
      artworks: [
        {
          name: 'Portrait of Adeline Ravoux',
          extensions: ['1890'],
          link: 'https://www.google.com/search?link_to_artwork/1890',
          image: nil,
        }, {
          name: 'Irises',
          extensions: ['1889'],
          link: 'https://www.google.com/search?link_to_artwork/1889',
          image: 'data:image/jpeg;base64,DATAFOR1889',
        }
      ],
    }

    expect(object.extract).to eq(expected_result)
  end
end
