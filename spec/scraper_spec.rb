require_relative '../lib/scraper'

describe Scraper do
  let(:json_data) { Scraper.new.scrape }
  let(:empty_carousel) { Scraper.new('files/van-gogh-paintings-empty.html').scrape }
  let(:artworks) { json_data[:artworks] }

  describe '#scrape' do
    context 'when carousel is present' do
      it 'returns json Array' do
        expect(artworks).to be_a_kind_of(Array)
      end

      it 'contains artworks' do
        expect(json_data).to have_key(:artworks)
      end

      it 'saves json file' do
        expect(File.exist?('files/van-gogh-paintings.json')).to be_truthy
      end
    end

    context 'when carousel is not present' do
      it 'raises error if carousel is not present' do
        expect{ empty_carousel }.to raise_error(StandardError).with_message('Google carousel is not present on the page!')
      end
    end
  end
end