require 'rspec'

RSpec.describe CarouselScraper::CarouselItemParser do
  subject(:parser) { described_class.new(node, encoded_images) }
  let(:node) { Nokogiri::HTML(html).css('a').first }
  let(:encoded_images) do
    {
      "kximg0" => "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD..."
    }
  end

  context 'with a valid carousel item' do
    let(:html) { File.read('spec/fixtures/valid_carousel_item.html') }

    it 'parses the title' do
      expect(parser.title).to eq('The Starry Night')
    end

    it 'finds the correct encoded image' do
      expect(parser.image).to eq(encoded_images["kximg0"])
    end

    it 'returns the correct url' do
      expect(parser.url).to eq('https://www.google.com/url-for-starry-night')
    end

    it 'returns the correct year' do
      expect(parser.year).to eq(['1889'])
    end

    it 'identifies a valid carousel item' do
      expect(parser.valid_carousel_item?).to be true
    end
  end

  context 'with an invalid carousel item' do
    let(:html) { File.read('spec/fixtures/invalid_carousel_item.html') }

    describe '#valid_carousel_item?' do
      it 'returns false' do
        expect(parser.valid_carousel_item?).to be(false)
      end
    end

    describe '#transform' do
      it 'returns nil' do
        expect(parser.transform).to be_nil
      end
    end
  end
end
