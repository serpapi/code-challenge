# frozen_string_literal: true

require 'rspec'
require_relative '../script/art_works_parser.rb'

RSpec.describe ArtWorksParser do
  let(:art_works) { described_class.new('files/van-gogh-paintings.html') }
  let(:result) { JSON.parse(art_works.parse) }

  describe 'successfullt parsing html file' do
    it 'present result' do
      expect(result.keys).to include('artworks')
      expect(result).not_to be_nil
    end

    it 'return format' do
      expect(result).to be_a_kind_of(Hash)
      expect(result['artworks']).to be_a_kind_of(Array)
      expect(result['artworks'][0].keys).to include('name', 'extensions', 'link', 'image')
    end

    context 'expected result from file' do
      let(:first_row) { result['artworks'][0] }

      it 'match name' do
        expect(first_row['name']).to eq('The Starry Night')
      end

      it 'match extensions' do
        expect(first_row['extensions']).to be_a_kind_of(Array)
        expect(first_row['extensions']).to include('1889')
      end

      it 'match link' do
        expect(first_row['link']).to match(/www.google.com/)
      end

      it 'match image' do
        expect(first_row['image']).not_to be_nil
      end
    end
  end
end
