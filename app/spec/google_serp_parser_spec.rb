require 'google_serp_parser'
require 'json'
require 'uri'

describe GoogleSerpParser do
  it 'Van Gogh Paintings carousel matches expected JSON file' do
    source_html = 'spec/support/van-gogh-paintings.html'
    expected_js = 'spec/support/van-gogh-paintings_expected.json'

    carousel = GoogleSerpParser.new(source_html).parse_carousel
    expected = JSON.load(File.read(expected_js))

    expect(carousel.to_json).to eql(expected.to_json)
  end
end
