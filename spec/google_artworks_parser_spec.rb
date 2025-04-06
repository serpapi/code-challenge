# frozen_string_literal: true

require 'json'
require_relative File.join('..', 'lib', 'google_artworks_parser')

def files_dir
  File.join(File.dirname(File.expand_path(__FILE__)), '..', 'files')
end

def fixture_path(artist)
  File.join(files_dir, "#{artist}-paintings.html")
end

van_gogh_html = fixture_path('van-gogh')
fixtures = {
  'Van Gogh' => van_gogh_html, 'Banksy' => fixture_path('banksy'), 'Warhol' => fixture_path('warhol')
}

describe GoogleArtworksParser do
  subject { described_class.parse }

  fixtures.each do |fixture_name, fixture|
    result = described_class.parse(fixture)
    artworks = result['artworks']

    it "can parse the #{fixture_name} fixture" do
      expect(artworks).to be_an(Array)
      expect(artworks).not_to be_empty
    end

    it "can parse the #{fixture_name} fixture - name" do
      artworks.each do |artwork|
        expect(artwork['name']).to be_a(String)
        expect(artwork['name']).not_to be_empty
      end
    end

    artworks.each do |artwork|
      artwork_name = artwork['name']
      it "can parse the #{fixture_name} fixture for #{artwork_name} - link" do
        expect(artwork['link']).to be_a(String)
        expect(artwork['link']).not_to be_empty
      end

      it "can parse the #{fixture_name} fixture for #{artwork_name} - image" do
        expect(artwork['image']).to be_a(String)
        expect(artwork['image']).not_to be_empty
        expect(artwork['image']).not_to start_with('data:image/gif;base64,')
      end

      it "can parse the #{fixture_name} fixture for #{artwork_name} - extensions" do
        expect(artwork['extensions']).to(satisfy { |v| v.nil? || (v.is_a?(Array) && !v.empty?) })
      end
    end
  end

  it 'matches the expected output for the Van Gogh fixture' do
    result = described_class.parse(van_gogh_html)
    expected_array = JSON.parse(File.read(File.join(files_dir, 'expected-array.json')))
    expect(result).to eq(expected_array)
  end
end
