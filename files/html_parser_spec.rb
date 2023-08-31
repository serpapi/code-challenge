require_relative 'html_parser'
require 'json'

RSpec.describe 'HTML Parser' do
  describe 'parsing' do
    it 'extracts painting information from HTML' do
      # Load the HTML file for testing
      html_filename = 'van-gogh-paintings.html'
      html_content = File.read(html_filename)

      # Stub the Nokogiri::HTML method to return the test HTML content
      allow(Nokogiri).to receive(:HTML).and_return(Nokogiri::HTML(html_content))

      # Call the parse method and get the result
      result = HTMLParser.parse_paintings(html_filename)

      # Load the expected result from a JSON file
      expected_result = JSON.parse(File.read('expected-array.json'))

      # Compare the parsed result with the expected result
      expect(result).to eq(expected_result)
    end
  end

  describe 'output file' do
    it 'matches the expected output' do
      # Load the generated output JSON
      generated_output_filename = 'van-gogh-paintings_output.json'
      generated_output = JSON.parse(File.read(generated_output_filename))

      # Load the expected output JSON
      expected_output_filename = 'expected-array.json'
      expected_output = JSON.parse(File.read(expected_output_filename))

      # Compare the generated output with the expected output
      expect(generated_output).to eq(expected_output)
    end
  end
end
