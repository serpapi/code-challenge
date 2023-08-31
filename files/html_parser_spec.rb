require_relative 'html_parser'
require 'json'

RSpec.describe 'HTML Parser' do
  describe 'parsing' do
    it 'extracts painting information from HTML' do
      html = File.read('sample.html')
      allow(File).to receive(:open).and_return(html)
    end
  end

  describe 'output file' do
    let(:expected_output_filename) { 'expected-array.json' }
    let(:generated_output_filename) { 'output.json' }

    it 'matches the expected output' do
      generated_output = JSON.parse(File.read(generated_output_filename))
      expected_output = JSON.parse(File.read(expected_output_filename))

      expect(generated_output).to eq(expected_output)
    end
  end
end
