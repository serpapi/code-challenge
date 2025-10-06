# frozen_string_literal: true

require_relative '../lib/paintings_parser'
require 'json'

RSpec.describe PaintingsParser do
  let(:van_gogh_html) { File.read('files/van-gogh-paintings.html', encoding: 'UTF-8') }
  let(:expected_array) { JSON.parse(File.read('files/expected-array.json', encoding: 'UTF-8'))['artworks'] }
  let(:parser) { PaintingsParser.new(van_gogh_html) }

  describe '#parse' do
    context 'with Van Gogh paintings' do
      let(:result) { parser.parse }

      it 'returns an array' do
        expect(result).to be_an(Array)
      end

      it 'extracts the  number of paintings' do
        expect(result.length).to eq(expected_array.length)
      end

      it 'extracts painting names' do
        result_names = result.map { |p| p['name'] }
        expected_names = expected_array.map { |p| p['name'] }

        expected_names.each do |name|
          expect(result_names).to include(name)
        end
      end

      it 'extracts extensions (dates)' do
        result.each do |painting|
          expect(painting).to have_key('extensions')
          expect(painting['extensions']).to be_an(Array)
        end
      end

      it 'extracts Google links' do
        result.each do |painting|
          expect(painting).to have_key('link')
          expect(painting['link']).to be_a(String)
          expect(painting['link']).to match(%r{^https?://})
        end
      end

      it 'extracts thumbnails' do
        result.each do |painting|
          expect(painting).to have_key('image')
          expect(painting['image']).to match(%r{^https?://|^data:image}) if painting['image']
        end
      end

      it 'checks matches the expected output structure' do
        expect(result.first.keys.sort).to eq(expected_array.first.keys.sort) if result.first && expected_array.first
      end
    end

    context 'with movies carousel' do
      let(:movies_html) { File.read('files/test-movies.html') }
      let(:movies_parser) { PaintingsParser.new(movies_html) }
      let(:result) { movies_parser.parse }

      it 'returns an array of results' do
        expect(result).to be_an(Array)
        expect(result.length).to eq(16)
      end

      it 'extracts names from movie carousel' do
        result.each do |item|
          expect(item['name']).to be_a(String)
          expect(item['name']).not_to be_empty
        end
      end

      it 'extracts links from movie carousel' do
        result.each do |item|
          expect(item['link']).to be_a(String)
          expect(item['link']).to match(%r{^https?://})
        end
      end

      it 'extracts thumbnails from movie carousel' do
        result.each do |item|
          expect(item).to have_key('image')
          expect(item['image']).to match(%r{^https?://|^data:image}) if item['image'] && !item['image'].empty?
        end
      end

      it 'checks has consistent data structure' do
        result.each do |item|
          expect(item).to have_key('name')
          expect(item).to have_key('link')
          expect(item).to have_key('extensions')
          expect(item).to have_key('image')
        end
      end
    end

    context 'with books carousel' do
      let(:books_html) { File.read('files/test-books.html') }
      let(:books_parser) { PaintingsParser.new(books_html) }
      let(:result) { books_parser.parse }

      it 'returns an array of results' do
        expect(result).to be_an(Array)
        expect(result.length).to eq(22)
      end

      it 'extracts names from books carousel' do
        result.each do |item|
          expect(item['name']).to be_a(String)
          expect(item['name']).not_to be_empty
        end
      end

      it 'extracts links from books carousel' do
        result.each do |item|
          expect(item['link']).to be_a(String)
          expect(item['link']).to match(%r{^https?://})
        end
      end

      it 'extracts thumbnails from books carousel' do
        result.each do |item|
          expect(item).to have_key('image')
          expect(item['image']).to match(%r{^https?://|^data:image}) if item['image'] && !item['image'].empty?
        end
      end

      it 'has consistent data structure' do
        result.each do |item|
          expect(item).to have_key('name')
          expect(item).to have_key('link')
          expect(item).to have_key('extensions')
          expect(item).to have_key('image')
        end
      end
    end
  end
end
