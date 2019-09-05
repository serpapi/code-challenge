require_relative './main.rb'

RSpec.describe ArtworksParser do
  before :all do
    parser = ArtworksParser.new
    parse_results = parser.parse

    @artworks = parse_results[:artworks]
  end
  
  describe '#parse' do
    subject { @artworks }

    it { is_expected.to be_a(Array) }
    it { is_expected.to have(51).items }

    it { is_expected.to all( be_a(Artwork) ) }
    it { is_expected.to all( have_attributes(name: be_a(String)) ) }
    it { is_expected.to all( have_attributes(link: be_a(String)) ) }
    it { is_expected.to all( have_attributes(image: be_a(String).or(be(nil)) ) ) }
    it { is_expected.to all( have_attributes(extensions: be_a(Array).or(be(nil)) ) ) }
  end
end