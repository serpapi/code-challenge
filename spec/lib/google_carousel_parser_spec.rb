require 'spec_helper'
require_relative '../../lib/google_carousel_parser'
require 'pry'
require 'json'

RSpec.describe GoogleCarouselParser do
  subject(:results) { described_class.new(html).call }

  context 'when carousel is artworks' do
    let(:html) { File.read('files/van-gogh/van-gogh-paintings.html') }
    let(:json){ JSON.parse(File.read('files/van-gogh/expected-array.json')) }

    it 'parses artworks correctly' do
      expect(results).to eq json
    end
  end

  context 'when carousel is sport roaster' do
    let(:html) { File.read('files/lakers-roaster/lakers-roaster.html') }
    let(:json){ JSON.parse(File.read('files/lakers-roaster/expected-array.json')) }

    it 'parses correctly' do
      expect(results).to eq json
    end
  end

  context 'when carousel is tv cast' do
    let(:html) { File.read('files/stranger-things-cast/index.html') }
    let(:json){ JSON.parse(File.read('files/stranger-things-cast/expected-array.json')) }

    it 'parses correctly' do
      expect(results).to eq (json)
    end
  end

  context 'when carousel is a band' do
    let(:html) { File.read('files/jackson5-members/index.html') }
    let(:json){ JSON.parse(File.read('files/jackson5-members/expected-array.json')) }

    it 'parses correctly' do
      expect(results).to eq (json)
    end
  end

  context 'when carousel is a band' do
    let(:html) { File.read('files/kanye-albums/index.html') }
    let(:json){ JSON.parse(File.read('files/kanye-albums/expected-array.json')) }

    it 'parses correctly' do
      expect(results).to eq (json)
    end
  end
end
