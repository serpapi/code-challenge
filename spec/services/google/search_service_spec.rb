# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::SearchService do
  subject { Google::SearchService.new }

  let(:search_text) { 'van gogh paintings' }

  let(:fixture_name) { 'google_van_gogh_result.html' }
  let(:fixture) { File.read("#{Rails.root}/spec/fixtures/#{fixture_name}") }

  let(:paintings_json) { File.read("#{Rails.root}/spec/fixtures/paintings.json") }

  describe '#paintings' do
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
      result = subject.paintings(search_text)
      expect(result.map { |item| item.transform_keys(&:to_s) }).to eq(JSON.parse(paintings_json))
    end
  end
end