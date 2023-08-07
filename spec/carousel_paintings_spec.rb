require 'carousel_paintings'
require 'carousel_paintings_v1'
require 'carousel_paintings_v2'
require 'json'
require 'base64'

describe CarouselPaintings do
  let(:carousel) { described_class.new(document, parsers) }
  let(:parsers) { [] }

  describe '#data' do
    let(:document) { Nokogiri::HTML.parse(open('files/van-gogh-paintings.html')) }

    context 'with no parsers' do
      it 'does not return data' do
        expect(carousel.data).to be_nil
      end
    end

    context 'with V1 document' do
      let(:document) { Nokogiri::HTML.parse(open('files/van-gogh-paintings.html')) }

      context 'when parsers are in order' do
        let(:parsers) { [CarouselPaintingsV1, CarouselPaintingsV2] }

        it 'returns the correct number of paintings' do
          expect(carousel.data[:paintings].size).to eq(51)
        end
      end

      context 'when parsers are out of order' do
        let(:parsers) { [CarouselPaintingsV2, CarouselPaintingsV1] }

        it 'returns the correct number of paintings' do
          expect(carousel.data[:paintings].size).to eq(51)
        end
      end
    end

    context 'with V2 document' do
      let(:document) { Nokogiri::HTML.parse(open('files/head-of-a-peasant.html')) }

      context 'when parsers are in order' do
        let(:parsers) { [CarouselPaintingsV1, CarouselPaintingsV2] }

        it 'returns the correct number of paintings' do
          expect(carousel.data[:paintings].size).to eq(49)
        end
      end

      context 'when parsers are out of order' do
        let(:parsers) { [CarouselPaintingsV2, CarouselPaintingsV1] }

        it 'returns the correct number of paintings' do
          expect(carousel.data[:paintings].size).to eq(49)
        end
      end
    end

    context 'with another V2 document' do
      let(:document) { Nokogiri::HTML.parse(open('files/van-gogh-self-portrait.html')) }

      context 'when parsers are in order' do
        let(:parsers) { [CarouselPaintingsV1, CarouselPaintingsV2] }

        it 'returns the correct number of paintings' do
          expect(carousel.data[:paintings].size).to eq(49)
        end
      end

      context 'when parsers are out of order' do
        let(:parsers) { [CarouselPaintingsV2, CarouselPaintingsV1] }

        it 'returns the correct number of paintings' do
          expect(carousel.data[:paintings].size).to eq(49)
        end
      end
    end
  end
end
