require 'json'
require_relative './scrape' # Adjust the path as needed

RSpec.describe 'ArtworkExtractor' do
  let(:result) { ArtworkExtractor.new.get_artworks(File.read('./files/van-gogh-paintings.html')) }
  let(:expected) { JSON.parse(File.read('./files/expected-array.json'))['artworks'] }

  it 'create same size of items' do
    expect(result.size).to eq(expected.size)
  end

  it 'create same names as expected' do
    result_names = result.map { |r| r['name'] }
    expected_names = expected.map { |r| r['name'] }
    expect(result_names).to eq(expected_names)
  end

  it 'create same extensions as expected' do
    result_names = result.map { |r| r['extensions'] }
    expected_names = expected.map { |r| r['extensions'] }
    expect(result_names).to eq(expected_names)
  end

  it 'create same links as expected' do
    result_names = result.map { |r| r['link'] }
    expected_names = expected.map { |r| r['link'] }
    expect(result_names).to eq(expected_names)
  end

  it 'create same images as expected' do
    result_names = result.map { |r| r['image'] }
    expected_names = expected.map { |r| r['image'] }
    expect(result_names).to eq(expected_names)
  end
end
