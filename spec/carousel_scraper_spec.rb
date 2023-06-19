require_relative '../lib/carousel_scraper.rb'
require 'nokolexbor'

describe CarouselScraper do
  subject(:scraper) { described_class.new }

  let(:van_gogh_html) { File.read('files/van-gogh-paintings.html') }
  let(:empty_html) { "" }  # Mock empty HTML content

  let(:expected_first_artwork) do
    {
      "name"=>"The Starry Night",
      "extensions"=>["1889"],
      "link"=>"https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
      "image"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0"
    }
  end

  describe '#scrape' do
    subject(:result) { scraper.scrape(van_gogh_html) }

    before do
      expect(scraper).to receive(:get_carousel).and_call_original
      expect(scraper).to receive(:get_carousel_heading).and_call_original
      expect(scraper).to receive(:get_carousel_content).and_call_original
    end

    it 'calls the necessary methods to get the carousel and its content' do
      result
    end

    it 'returns a hash with the correct heading as a key' do
      expect(result).to be_a(Hash)
      expect(result.keys.first).to eq('Artworks')
    end

    it 'returns a hash with an array of mapped carousel content as value' do
      expect(result.values.first).to be_a(Array)
    end

    it 'returns correct information for the first artwork' do
      first_artwork = result.values.first.first
      expect(first_artwork).to match(expected_first_artwork)
    end
  end

  context 'when HTML content is empty' do
    it 'outputs an error message and returns nil' do
      expect(STDOUT).to receive(:puts).with('Error occurred: Failed to get carousel from HTML content')
      expect(scraper.scrape(empty_html)).to be_nil
    end
  end

end
