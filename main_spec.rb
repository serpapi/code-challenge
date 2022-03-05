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
    end
  end
end
