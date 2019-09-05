require_relative './main.rb'

RSpec.describe ArtworksParser do
  let(:parser) { ArtworksParser.new }

  describe '#parse' do
    [
      [ './files/van-gogh-paintings.html', 51 ],
      [ './files/da-Vinci-paintings.html', 50 ],
      [ './files/ilya-repin-paintings.html', 50 ],
    ].each do |path, count|
      context "When path is '#{path}'" do
        subject { parser.parse(path)[:artworks] }

        it { is_expected.to be_a(Array) }
        it { is_expected.to have(count).items }

        it { is_expected.to all( be_a(Artwork) ) }
        it { is_expected.to all( have_attributes(name: be_a(String)) ) }
        it { is_expected.to all( have_attributes(link: be_a(String)) ) }
        it { is_expected.to all( have_attributes(image: be_a(String).or(be(nil)) ) ) }
        it { is_expected.to all( have_attributes(extensions: be_a(Array).or(be(nil)) ) ) }
      end
    end
  end
end