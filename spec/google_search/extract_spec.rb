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

  it 'matches the artworks from the challenge expected array' do
    expected = JSON.parse(File.read(File.expand_path('../../files/expected-array.json', __dir__)))

    expect(JSON.parse(extract.to_json)).to eq(expected['artworks'])
  end

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

  context 'with layout variations' do
    def extract_html(html)
      described_class.new(StringIO.new(html))
    end

    def carousel_html(attrid: 'kc:/visual_art/visual_artist:works', anchors: nil)
      anchors ||= <<~HTML
        <a href="/search?q=one"><img data-src="https://thumbs.test/1"><div><div>First
          Painting</div><div>1889</div></div></a>
        <a href="https://www.google.com/search?q=two"><img data-src="https://thumbs.test/2"><div><div>Second</div></div></a>
      HTML
      "<html><body><div data-attrid=\"#{attrid}\">#{anchors}</div></body></html>"
    end

    it 'collapses whitespace inside names' do
      expect(extract_html(carousel_html).results.first.name).to eq('First Painting')
    end

    it 'keeps absolute Google search links as-is' do
      expect(extract_html(carousel_html).results.last.link).to eq('https://www.google.com/search?q=two')
    end

    it 'ignores search-refinement sections' do
      %w[kc:/people/person:sideways kc:/common:downwards].each do |attrid|
        expect(extract_html(carousel_html(attrid: attrid)).results).to eq([])
      end
    end

    it 'prefers anchor labels over captions with wrapped names' do
      wrapped = <<~HTML
        <a href="/search?q=one" aria-label="The Devil All the Time"><img data-src="https://thumbs.test/1"><div><div>The Devil All the</div><div>Time</div></div></a>
        <a href="/search?q=two" title="Other Movie"><img data-src="https://thumbs.test/2"><div><div>Other</div><div>Movie</div></div></a>
      HTML
      results = extract_html(carousel_html(anchors: wrapped)).results

      expect(results.map(&:name)).to eq(['The Devil All the Time', 'Other Movie'])
      expect(results.map(&:extensions)).to eq([nil, nil])
    end

    it 'ignores groups with a single item' do
      single = '<a href="/search?q=one"><img data-src="https://thumbs.test/1"><div><div>Only</div></div></a>'

      expect(extract_html(carousel_html(anchors: single)).results).to eq([])
    end
  end
end
