# frozen_string_literal: true

require 'rspec'
require_relative '../lib/extractor'

# rubocop:disable Metrics/BlockLength
describe Extractor do
  let(:html_path) { './files/van-gogh-paintings.html' }
  let(:json_path) { './files/van-gogh-paintings.json' }
  let(:invalid_html_path) { './files/missing.html' }
  let(:invalid_json_path) { './files/missing.json' }
  let(:empty_html_path) { './files/empty.html' }
  let(:empty_json_path) { './files/empty.json' }
  let(:expected_array) do
    JSON.parse(File.read('./files/expected-array.json'), symbolize_names: true)
  end

  subject { Extractor.new(html_path, json_path).call }

  before do
    File.write(empty_html_path, '')
    File.write(empty_json_path, '{}')
  end

  after do
    FileUtils.rm_f(empty_html_path)
    FileUtils.rm_f(empty_json_path)
  end

  it 'returns an empty array for empty HTML and JSON files' do
    extractor = Extractor.new(empty_html_path, empty_json_path)
    expect(extractor.call).to eq([])
  end

  it 'handles invalid HTML file path' do
    expect { Extractor.new(invalid_html_path, json_path).call }.to raise_error(Errno::ENOENT)
  end

  it 'handles invalid JSON file path' do
    expect { Extractor.new(html_path, invalid_json_path).call }.to raise_error(Errno::ENOENT)
  end

  it 'extracts the correct data from the HTML and JSON files' do
    expect(subject).to eq(expected_array)
  end
end
# rubocop:enable Metrics/BlockLength
