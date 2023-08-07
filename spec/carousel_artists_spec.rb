require 'carousel_artists'
require 'json'

describe CarouselArtists do
  let(:document) { Nokogiri::HTML.parse(open('files/van-gogh-artwork.html')) }
  let(:carousel) { CarouselArtists.new(document) }

  describe '#data' do
    it 'returns a hash with paintings' do
      expect(carousel.data[:paintings].size).to eq(13)
    end

    it 'returns correct caption for the first painting' do
      expect(carousel.data[:paintings].first[:caption]).to eq('Pablo Picasso dzieła')
    end

    it 'returns correct link for the first painting' do
      expect(carousel.data[:paintings].first[:link]).to eq('https://www.google.com/search?sa=X&sxsrf=AB5stBgGMnNgzkm6d2QKz0GSs9c3WrNM2Q:1691067029323&si=ACFMAn9QlknPajhCNTwKxAtikEYpBB7cuv61qHlfIUqzAnvzXyg8_HaTgf2ZNdy1aQVjuXOeQPlLPKCBj1SNAy-djykg6TksrGa7O1oe__QE41gN415SPPuJ_NPNyuq7uumGJX778b7qzRT-P0x51UQ5kXpk5XFIuLB6bPx44UeYepMmKG5kS0amqA9i6kReC7sB-i2bpp6sdARb_ys6Wu4q93nf-bya0_R8YcCYAlPI5FdSpyXZUBatIL3eeOTr3qYdjWVdemN-&q=Pablo+Picasso+dzie%C5%82a&ved=2ahUKEwj7wsvMw8CAAxVyIxAIHagWAQsQ-BZ6BAgOEAY')
    end

    it 'returns correct image for the first painting' do
      expect(carousel.data[:paintings].first[:image]).to eq('data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')
    end

    it 'returns only pre-defined data keys' do
      expect(carousel.data[:paintings].first.keys).to eq([:caption, :link, :image])
    end

    it 'returns correct caption for the last painting' do
      expect(carousel.data[:paintings].last[:caption]).to eq('Edgar Degas dzieła')
    end

    it 'returns correct link for the last painting' do
      expect(carousel.data[:paintings].last[:link]).to eq('https://www.google.com/search?sa=X&sxsrf=AB5stBgGMnNgzkm6d2QKz0GSs9c3WrNM2Q:1691067029323&si=ACFMAn9QlknPajhCNTwKxAtikEYpBB7cuv61qHlfIUqzAnvzX2YsH5IYyL3JgwAvzxo1nOwh8aUABShTV80raZm8Keu4NfXVwz6vvXagKlY8PqaaK4RNAnV4V_3kElDplVLlbhdQruhXBKrFGNTX3S35xybTrwFFuTSFAKgS8DS5LW_-wklRXfUhJ9SEt2c9zqkspTULokXOEuvyUmL3n0rzh2RyM7zN-PMAEXjapn2HBak-Gemlj3qnnZSgKoTWjXdLIycXFMen&q=Edgar+Degas+dzie%C5%82a&ved=2ahUKEwj7wsvMw8CAAxVyIxAIHagWAQsQ-BZ6BAgOECo')
    end

    it 'returns correct image for the last painting' do
      expect(carousel.data[:paintings].last[:image]).to eq('data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==')
    end

    it 'returns an empty list if no image tiles are found' do
      expect(CarouselArtists.new(Nokogiri::HTML.parse('<html><body><div></div></body></html>')).data[:paintings].size).to eq(0)
    end
  end

  describe '#to_json' do
    it 'returns a json string with paintings' do
      expect(JSON.parse(carousel.to_json)['paintings'].size).to eq(13)
    end
  end
end