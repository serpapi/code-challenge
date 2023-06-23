require 'rspec'

RSpec.describe CarouselScraper::CarouselItemParser do
  let(:encoded_images) do
    {
      "kximg0" => "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD..."
    }
  end

  context 'when the image has a data-key' do
    let(:html) { File.read('spec/fixtures/carousel_item_with_data_key.html') }
    let(:node) { Nokogiri::HTML(html).css('a').first }
    subject(:parser) { described_class.new(node, encoded_images) }

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

  context 'when the image does not have a data-key' do
    let(:html) { File.read('spec/fixtures/carousel_item_without_data_key.html') }
    let(:node) { Nokogiri::HTML(html).css('a').first }
    subject(:parser) { described_class.new(node, encoded_images) }

    it 'parses the title' do
      expect(parser.title).to eq('The Yellow House')
    end

    it 'does not have an image URL' do
      expect(parser.image).to be_nil
    end

    it 'returns the correct url' do
      expect(parser.url).to eq('https://www.google.com/url-for-the-yellow-house')
    end

    it 'returns the correct year' do
      expect(parser.year).to eq(['1888'])
    end

    it 'identifies a valid carousel item' do
      expect(parser.valid_carousel_item?).to be true
    end
  end
end
