require 'json'
require_relative './scrape' # Adjust the path as needed

RSpec.describe 'get_artworks_from_html' do
  it 'parses HTML content and returns expected JSON data' do
    html_content = File.read('./files/van-gogh-paintings.html')
    result = get_artworks_from_html(html_content)

    expected_json = File.read('./files/expected-array.json')
    expected_data = JSON.parse(expected_json)

    expect(result['artworks']).to eq(expected_data['artworks'])
  end
end
