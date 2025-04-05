# frozen_string_literal: true

require 'json'
require_relative File.join('..', 'lib', 'google_artworks_parser')

files_dir = File.join(File.dirname(File.expand_path(__FILE__)), '..', 'files')
expected_array = JSON.parse(File.read(File.join(files_dir, 'expected-array.json')))
van_gogh_html = File.join(files_dir, 'van-gogh-paintings.html')

describe GoogleArtworksParser do
  subject { described_class.parse }

  it 'runs without errors' do
    expect do
      described_class.parse(van_gogh_html)
    end.not_to raise_error
  end

  it 'matches the expected output for the Van Gogh fixture (excluding image property)' do
    result = described_class.parse(van_gogh_html)

    normalized_expected = expected_array['artworks'].map do |artwork|
      artwork.reject { |k, _| k == 'image' }
    end
    normalized_result = result['artworks'].map do |artwork|
      artwork.reject { |k, _| k == 'image' }
    end

    expect(normalized_result).to eq(normalized_expected)
  end

  it 'matches the expected image for the Van Gogh fixture output' do
    result = described_class.parse(van_gogh_html)

    expected_images = expected_array['artworks'].map do |artwork|
      artwork['image']
    end
    result_images = result['artworks'].map do |artwork|
      artwork['image']
    end

    expect(result_images).to eq(expected_images)
  end

  it 'matches the expected output for the Van Gogh fixture' do
    result = described_class.parse(van_gogh_html)
    expect(result).to eq(expected_array)
  end
end
