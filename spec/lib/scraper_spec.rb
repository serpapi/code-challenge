# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/scraper'

RSpec.describe Scraper do
  subject { JSON.parse(Scraper.new(path).call) }

  context 'van gogh paintings' do
    let(:path) { './files/van-gogh-paintings.html' }
    let(:expected_json) { JSON.parse(File.read('./files/expected-array.json')) }

    it 'parses the HTML and returns the expected JSON' do
      expect(subject).to eq(expected_json)
    end
  end

  context 'monet paintings' do
    let(:path) { './files/monet-paintings.html' }
    let(:expected_json) { JSON.parse(File.read('./files/monet-paintings-expected-array.json')) }

    it 'parses the HTML and returns the expected JSON' do
      expect(subject).to eq(expected_json)
    end
  end
end
