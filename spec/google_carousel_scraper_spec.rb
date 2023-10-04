# frozen_string_literal: true

require 'google_carousel_scraper'

require 'nokolexbor'
require 'json'
require 'uri'

RSpec.describe GoogleCarouselScraper do
  def new_scraper(file)
    doc = Nokolexbor::Document.parse(File.read(File.join('files', file)))
    GoogleCarouselScraper.new(doc)
  end

  context 'with no carousel' do
    before(:example) do
      @carousel = new_scraper('greg-rutkowski-art-2023-04-10.html')
    end

    describe '#each' do
      it 'yields no items' do
        expect(@carousel.to_a).to be_empty
      end
    end
  end

  context 'with historic van gogh page' do
    before(:example) do
      @carousel = new_scraper('van-gogh-paintings.html')
      @items = @carousel.to_a.flatten
      @expected = JSON.parse(File.read('files/van-gogh-paintings.json'))
                      .dig('knowledge_graph', 'artworks')
    end

    describe '#each' do
      it 'yields an expected number of items' do
        expect(@items.length).to eq(@expected.length)
      end

      it 'yields expected contents' do
        @expected.zip(@items) do |expected, actual|
          expect(actual.keys - %w[name link extensions image]).to be_empty
          expect(actual['name']).to eq(expected['name'])
          expect(actual['link']).to eq(expected['link'])
          expect(actual['extensions']).to eq(expected['extensions'])

          # Padding is corrupted in target data, encoded as trailing 'x3d'
          expected_image = expected['image']&.gsub(/(x3d)+$/) { |m| '=' * (m.length / 3) }
          expect(actual['image']).to eq(expected_image)
        end
      end
    end
  end

  %w[modern-art-paintings-2023-04-10.html steven-spielberg-films-2023-04-10.html].each do |file|
    context "with #{file}" do
      before(:example) do
        @carousel = new_scraper(file)
        @items = @carousel.to_a.flatten
      end

      describe '#each' do
        it 'yields a single carousel' do
          expect(@carousel.count).to eq(1)
        end

        it 'yields items' do
          expect(@items).to_not be_empty
        end

        it 'yields contentful names' do
          @items.map { |x| x['name'] }.each do |item|
            expect(item).to be_kind_of(String)
            expect(item).to_not be_empty
          end
        end

        it 'yields valid links' do
          @items.map { |x| x['link'] }.each do |item|
            expect(item).to be_kind_of(String)
            expect(item).to_not be_empty

            expect do
              parsed = URI.parse(item)
              expect(parsed.absolute?).to be true
            end.not_to raise_error
          end
        end
      end
    end
  end
end
