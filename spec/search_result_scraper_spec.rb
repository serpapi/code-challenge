require 'json'
require_relative '../search_result_scraper'

RSpec.describe SearchResultScraper do
  describe '#artworks' do
    [
      {
        name: 'Van Gogh',
        path: 'spec/fixtures/van_gogh_paintings.html',
        count: 50
      },
      {
        name: 'Vlaho Bukovac',
        path: 'spec/fixtures/vlaho_bukovac_paintings.html',
        count: 30
      },
      {
        name: 'Edgar Degas',
        path: 'spec/fixtures/edgar_degas_paintings.html',
        count: 49
      }
    ].each do |example|
      context "when #{example[:name]} paintings" do
        subject(:scraper) { described_class.new(example[:path]) }

        let(:artworks) { scraper.fetch_results[:artworks] }

        it 'parse results into correct data type' do
          expect(artworks).to be_a Array
        end

        it 'returns array with correct number of elements' do
          expect(artworks.count).to eq example[:count]
        end

        it 'parse correctly name for first element' do
          expect(artworks[0][:name]).to be_a String
        end

        it 'parse correctly extensions for first element' do
          expect(artworks[0][:extensions]).to be_a Array
        end

        context 'when link' do
          let(:link) { artworks[0][:link] }

          it 'parse correctly link for first element' do
            expect(link).to be_a String
          end

          it "starts with 'https://www.google.com'" do
            expect(link).to start_with 'https://www.google.com'
          end
        end

        context 'when image' do
          let(:image) { artworks[0][:image] }

          it 'parse correctly image for first element' do
            expect(image).to be_a String
          end

          it "starts with 'data:image'" do
            expect(image).to start_with 'data:image'
          end
        end
      end
    end
  end
end
