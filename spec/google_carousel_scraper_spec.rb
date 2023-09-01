# frozen_string_literal: true

require_relative '../google_carousel_scraper'
require 'json'

RSpec.describe GoogleCarouselScraper do
  let(:html_files) { ['files/van-gogh-paintings.html', 'files/la-vie-painting.html', 'files/self-portrait.html'] }
  let(:expected_json_files) do
    ['spec/responses/van-gogh-paintings.json', 'spec/responses/la-vie-painting.json', 'spec/responses/self-portrait.json']
  end

  describe '#call' do
    before do
      @scrapers = html_files.map { |html_file| GoogleCarouselScraper.new(html_file) }
      @expected_json = expected_json_files.map { |json_file| JSON.parse(File.read(json_file)) }
    end

    it 'scrapes elements from the HTML pages' do
      @scrapers.each_with_index do |scraper, index|
        expect(scraper.call.count).to eq(@expected_json[index].count)
        expect(scraper.call.map { |hash| hash.transform_keys(&:to_s) }).to include(*@expected_json[index])
      end
    end
  end
end
