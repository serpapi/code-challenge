require_relative '../lib/painting'

describe Painting do

  let(:painting) { Painting.new(name: 'The Starry Night', link: 'https://google.com', image: 'https://google.com', extensions: ['1889']) }

  describe '#to_json' do
    it 'returns json object' do
      expect(painting.to_json).to be_a_kind_of(Hash)
    end
  end
end