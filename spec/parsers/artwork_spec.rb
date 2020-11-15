RSpec.describe Parsers::Artwork do
  subject(:artworks) { instance.parse }

  let(:file) { File.read('files/van-gogh-paintings.html') }
  let(:instance) { described_class.new(file: file) }

  it { is_expected.to be_a(Array) }
  its(:size) { is_expected.to eq(51) }

  describe 'first artwork' do
    subject(:artwork) { artworks.first }

    it { is_expected.to be_a(Hash) }
    it { is_expected.to include(:name, :extensions, :link, :image) }

    its([:name]) { is_expected.to be_a(String) }
    its([:link]) { is_expected.to start_with('https://google.com/search') }
    its([:image]) { is_expected.to start_with('data:image/gif;base64') }

    describe ':extensions' do
      subject(:extensions) { artwork[:extensions].first }

      it { is_expected.to be_a(String) }
      its(:size) { is_expected.to eq(4) }
    end
  end
end
