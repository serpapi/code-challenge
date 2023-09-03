# frozen_string_literal: true

require_relative '../../lib/image_carrousel_scrapper'
require_relative '../../lib/image_carrousel_scrapper/drivers/nokogiri_driver'
require 'json'

RSpec.describe ImageCarrouselScrapper do
  subject(:result) { described_class.new(driver:, file:).result(format: :raw)[:artworks] }

  let(:file) { File.open('./spec/fixtures/van-gogh-paintings.html') }
  let(:expected_data) { JSON.load_file('./spec/fixtures/expected-array.json', symbolize_names: true)[:artworks] }

  context 'using nokogiri driver' do
    let(:driver) { ImageCarrouselScrapper::Drivers::NokogiriDriver }

    it 'result, return list of carrousel data' do
      expect(result).to eq(expected_data)
    end
  end
end
