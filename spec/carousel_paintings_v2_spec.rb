require 'carousel_paintings_v2'
require 'json'
require 'base64'

describe CarouselPaintingsV2 do
  let(:document) { Nokogiri::HTML.parse(open('files/head-of-a-peasant.html')) }
  let(:carousel) { described_class.new(document) }

  describe '#data' do
    it 'returns a hash with paintings' do
      expect(carousel.data[:paintings].size).to eq(49)
    end

    it 'returns correct name for the first painting' do
      expect(carousel.data[:paintings].first[:name]).to eq('The Starry Night')
    end

    it 'returns correct link for the first painting' do
      expect(carousel.data[:paintings].first[:link]).to eq('https://www.google.com/search?sa=X&gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8omcDGCACEQP0nrQAAAA&ved=2ahUKEwjl65ifx8qAAxXYFBAIHXgLDoQQ-BZ6BAgpEA4')
    end

    it 'returns correct image for the first painting' do
      expect(carousel.data[:paintings].first[:image]).to eq('data:image/jpeg;base64,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')
    end

    it 'returns correct extensions for the first painting' do
      expect(carousel.data[:paintings].first[:extensions]).to eq(['1889'])
    end

    it 'returns only pre-defined data keys' do
      expect(carousel.data[:paintings].first.keys).to eq([:name, :extensions, :link, :image])
    end

    it 'returns correct name for the last painting' do
      # NOTE: for some I couldn't save the entirely loaded page. Instead of 26, this should be the last element.
      expect(carousel.data[:paintings][26][:name]).to eq('Garden with Courting Couples: Square Saint-Pierre')
    end

    it 'returns correct link for the last painting' do
      # NOTE: for some I couldn't save the entirely loaded page. Instead of 26, this should be the last element.
      expect(carousel.data[:paintings][26][:link]).to eq('https://www.google.com/search?sa=X&gl=us&hl=en&q=Garden+with+Courting+Couples:+Square+Saint-Pierre&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1U_XNzRMNi1OKzOqzNVSyk620i_LLC5NzIlPLCpBYmYWl1iV5xdlFz9ijOQWePnjnrBUwKQ1J68xenERoUlIhYvNNa8ks6RSSIqLRwpuvwaDFBcXnMeziNXQPbEoJTVPoTyzJEPBOb8UaEZeOohRkJNabKUQXFiaWJSqEJyYmVeiG5CZWlSUOoGNEQAR1P2j0gAAAA&ved=2ahUKEwjl65ifx8qAAxXYFBAIHXgLDoQQ-BZ6BAgpEFw')
    end

    it 'returns correct image for the last painting' do
      # NOTE: for some I couldn't save the entirely loaded page. Instead of 26, this should be the last element.
      expect(carousel.data[:paintings][26][:image]).to eq('data:image/jpeg;base64,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')
    end

    it 'returns an empty list if no image tiles are found' do
      expect(described_class.new(Nokogiri::HTML.parse('<html><body><div></div></body></html>')).data[:paintings].size).to eq(0)
    end
  end

  describe '#to_json' do
    it 'returns a json string with paintings' do
      expect(JSON.parse(carousel.to_json)['paintings'].size).to eq(49)
    end
  end
end
