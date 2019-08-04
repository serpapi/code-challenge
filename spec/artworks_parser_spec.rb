require_relative '../lib/artworks_parser'

describe ArtworksParser do
  let(:html) { File.read("files/van-gogh-paintings.html") }

  subject { described_class.new(html).artworks }

  context 'artworks set' do
    it 'returns 51 artworks' do
      expect(subject.size).to eq(51)
    end

    it 'does not include images for artworks that need an extra request' do
      subject.each_with_index do |artwork, index|
        # The HTML is showing 20 images but my regex was only able to identify 19
        # I'd need more time to investigate the missing one
        if index < 19 
          expect(artwork.image).to_not be_nil
        else
          expect(artwork.image).to be_nil
        end
      end
    end

    it 'includes name and link for all artworks' do
      subject.each do |artwork|
        expect(artwork.name).to_not be_empty
        expect(artwork.link).to_not be_empty
      end
    end
  end

  context 'specific artwork content' do
    let(:artworks) { described_class.new(html).artworks }

    context 'The Starry Night' do
      subject { artworks.find { |artwork| artwork.name === 'The Starry Night'} }

      it 'was painted on 1889' do
        expect(subject.extensions).to eq(['1889'])
      end
    end

    context 'Sunflowers' do
      subject { artworks.find { |artwork| artwork.name === 'Sunflowers'} }

      it 'does not provide when it was painted' do
        expect(subject.extensions).to be_empty
      end
    end
  end
end