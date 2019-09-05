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
        let(:artworks) { parser.parse(path)[:artworks] }
        subject { artworks }

        it { is_expected.to be_a(Array) }
        it { is_expected.to have(count).items }

        it { is_expected.to all( be_a(Artwork) ) }
        it {
          is_expected.to all(have_attributes(
            name: be_a(String),
            extensions: be_a(Array)
              .or(be(nil)),
            link: be_a(String)
              .and(start_with('https://www.google.com')),
            image: be_a(String)
              .and(start_with('data:image/jpeg;base64,'))
              .or(be(nil))
          ))
        }

        describe 'First artwork' do
          subject { artworks.first }

          it { is_expected.to be_a(Artwork) }
          it {
            is_expected.to have_attributes(
              name: be_a(String),
              extensions: be_a(Array),
              link: be_a(String)
                .and(start_with('https://www.google.com')),
              image: be_a(String)
                .and(start_with('data:image/jpeg;base64,'))
            )
          }
        end
      end
    end
  end
end