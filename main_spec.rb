require_relative './main'

RSpec.describe GoogleParser do
  describe '#parse' do
    let(:path) { './files/van-gogh-paintings.html' }
    let(:parser) { described_class.new(path) }

    before do
      parser.parse
    end

    it 'parses first painting info successfully' do
      first_painting = parser.paintings.first
      expect(first_painting.name).to eq 'The Starry Night'
      expect(first_painting.extensions).to eq ['1889']
      expect(first_painting.link).to eq 'https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw'
    end
  end
end
