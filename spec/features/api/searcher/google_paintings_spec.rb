# frozen_string_literal: true

require 'feature_helper'

feature 'Searcher::GooglePaintings', type: :api do

  let(:search_text) { 'van gogh paintings' }

  let(:fixture_name) { 'google_van_gogh_result.html' }
  let(:fixture) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name}") }

  let(:paintings_json) { File.read("#{Rails.root}/spec/fixtures/paintings.json") }

  let(:expected_data) { { 'paintings' => JSON.parse(paintings_json) } }

  describe 'get' do
    before do
      stub_request(:get, "https://www.google.com/search?q=van%2Bgogh%2Bpaintings").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(
          status: 200,
          body: fixture,
          headers: {}
        )
    end

    it 'success' do
      page.driver.get(
        '/google_paintings',
        search: search_text
      )

      expect(page.status_code).to eq(200)
      expect(json).to eq(expected_data)
    end
  end
end