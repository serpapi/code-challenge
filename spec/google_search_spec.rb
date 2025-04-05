# frozen_string_literal: true

require_relative '../lib/serpapi'
require 'json'

##
# Tests for SerpAPI code challenge.
# Share one instance of Selenium web driver across all tests.
describe SerpAPI::GoogleSearch do
  instance = SerpAPI::GoogleSearch.new

  describe '.get_hash' do
    context 'given an HTML file (van Gogh)' do
      html_file = File.join(__dir__, 'fixtures/van-gogh/page.html')
      expected = JSON.parse(File.read(File.join(__dir__, 'fixtures/van-gogh/expected.json')))

      it 'returns the expected array' do
        expect(instance.get_hash(html_file)['knowledge_graph']).to eq(expected)
      end
    end

    context 'given an HTML file (Egon Schiele)' do
      html_file = File.join(__dir__, 'fixtures/egon-schiele/page.html')
      expected = JSON.parse(File.read(File.join(__dir__, 'fixtures/egon-schiele/expected.json')))

      it 'returns the expected array' do
        expect(instance.get_hash(html_file)['knowledge_graph']).to eq(expected)
      end
    end

    context 'given an HTML file (Richard Estes)' do
      html_file = File.join(__dir__, 'fixtures/richard-estes/page.html')
      expected = JSON.parse(File.read(File.join(__dir__, 'fixtures/richard-estes/expected.json')))

      it 'returns the expected array' do
        expect(instance.get_hash(html_file)['knowledge_graph']).to eq(expected)
      end
    end
  end
end
