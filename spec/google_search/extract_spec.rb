# frozen_string_literal: true

require 'json'
require 'stringio'
require_relative '../../lib/google_search/extract'

RSpec.describe GoogleSearch::Extract do
  pages_dir = File.expand_path('../fixtures/pages', __dir__)
  expected_dir = File.expand_path('../fixtures/expected', __dir__)

  Dir.glob(File.join(pages_dir, '*.html')).each do |page_path|
    name = File.basename(page_path, '.html')

    it "extracts #{name} to match its expected output" do
      extracted = JSON.parse(described_class.new(page_path).to_json)

      expect(extracted).to eq(JSON.parse(File.read(File.join(expected_dir, "#{name}.json"))))
    end
  end

  subject(:extract) { described_class.new(File.join(pages_dir, 'van-gogh-paintings.html')) }

  it 'returns ExtractedResult instances' do
    expect(extract.results).to all(be_a(GoogleSearch::ExtractedResult))
  end

  it 'memoizes the parsed results' do
    expect(extract.results).to equal(extract.results)
  end

  it 'accepts an IO instead of a path' do
    results = File.open(File.join(pages_dir, 'van-gogh-paintings.html')) do |file|
      described_class.new(file).results
    end

    expect(results).not_to be_empty
  end

  it 'returns an empty array when the page has no carousel' do
    expect(described_class.new(StringIO.new('<html><body></body></html>')).results).to eq([])
  end
end
