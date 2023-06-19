require_relative '../lib/carousel_scraper.rb'
require 'nokolexbor'

describe CarouselScraper do
  subject(:scraper) { described_class.new }

  let(:van_gogh_html) { File.read('files/van-gogh-paintings.html') }
  let(:french_bulldogs_html) { File.read('files/french-bulldogs.html') }
  let(:stephen_king_html) { File.read('files/stephen-king.html') }
  let(:empty_html) { "" }

  let(:expected_first_artwork_van_gogh) do
    {
      "name"=>"The Starry Night",
      "extensions"=>["1889"],
      "link"=>"https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
      "image"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0"
    }
  end

  let(:expected_second_bulldog_book) do
    {
      "name"=>"French Bulldog Training: Dog Training for Your French Bulldog Puppy",
      "extensions"=>["French Bulldog Training: Dog Training for Your French Bulldog Puppy"],
      "link"=>"https://www.google.com/search?sxsrf=APwXEddcqZYKfgruVZ_SVjgrZlmbU0iFGA:1687156966190&q=French+Bulldog+Training:+Dog+Training+for+Your+French+Bulldog+Puppy&si=AMnBZoEZ8aFftZu792frFYrnK9KQYGXRL3UTeDeHB9-uc0sfFXFNYqm0C4pE8iLJDuZ-QjwCJeSv0FulWuOL3SI-E1kepH5_aI-U4-f9bNY3qhXIALb9NoA8ln3u9qhwUdJsK0iF2JWKfWZYl0183mx0V8fuKMYJuka_G6dBxQg5a60go7PuASThVT3FFahVsYrHJqPRt1Kk8DvKEKGyU-2zM-otMbN92targGpbMM4ODQ5olFpKfKv6GY-qwMKL8_SYC2FNLe8hBNu9M4VE2vWdwIT-gRCAT-0WW8BAsZFqPiK3ZTDRPhLS9qZ87GXpOsXaXn93WbSKkO79NTlKVQoaYujhQQia5S3DOlrcVsN0dMEqwvWO-LE%3D&sa=X&ved=2ahUKEwiSqJm93c7_AhXnJUQIHS6VCgAQgOQBegQIRRAG",
      "image"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwWkf6OWNOm3Cw-iq2KfLQ1f42bc95zllwMSkXVG3DRKrH3opnIj4lTU18SQ&s=10"
    }
  end

  let(:expected_first_book_stephen_king) do
    {
      "name"=>"It",
      "extensions"=>["1986"],
      "link"=>"https://www.google.com/search?sxsrf=APwXEdcCW0oaOYMXIO4LdWXhk6AXvMMjjA:1687151893812&q=It+(novel)&stick=H4sIAAAAAAAAAONgFuLSz9U3yCqxNEgzVeIEsQ3zKpLitaSyk630k_Lzs_UTS0sy8ousQOxihfy8nMpFrFyeJQoaefllqTmaO1gZAf32fEhFAAAA&sa=X&ved=2ahUKEwjN87_Kys7_AhUsiO4BHf6lAswQgOQBegQIPRAE",
      "image"=>"data:image/jpeg;base64,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"
    }
  end

  describe '#scrape' do
    context 'when given Van Gogh HTML' do
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
        expect(first_artwork).to match(expected_first_artwork_van_gogh)
      end
    end

    context 'when given French Bulldogs HTML' do
      subject(:result) { scraper.scrape(french_bulldogs_html) }

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
        expect(result.keys.first).to eq('Books')
      end

      it 'returns a hash with an array of mapped carousel content as value' do
        expect(result.values.first).to be_a(Array)
      end

      it 'returns correct information for the first artwork' do
        second_item = result.values.first[1]
        expect(second_item).to match(expected_second_bulldog_book)
      end
    end

    context 'when given Stephen King HTML' do
      subject(:result) { scraper.scrape(stephen_king_html) }

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
        expect(result.keys.first).to eq('Books')
      end

      it 'returns a hash with an array of mapped carousel content as value' do
        expect(result.values.first).to be_a(Array)
      end

      it 'returns correct information for the first book' do
        first_book = result.values.first.first
        expect(first_book).to match(expected_first_book_stephen_king)
      end
    end
  end
end
