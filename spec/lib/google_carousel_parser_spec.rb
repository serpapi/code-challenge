require 'spec_helper'
require_relative '../../lib/google_carousel_parser'
require 'pry'
require 'json'

RSpec.describe GoogleCarouselParser do
  subject(:results) { described_class.new(html).call }

  context 'when carousel is artworks' do
    let(:html) { File.read('files/van-gogh-paintings.html') }
    let(:json){ JSON.parse(File.read('files/expected-array.json')) }

    it 'parses artworks correctly' do
      expect(results).to eq json['artworks']
    end
  end
end
