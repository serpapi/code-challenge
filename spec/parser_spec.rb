require_relative '../lib/scraper'
require_relative '../lib/parser'

describe Parser do
  let(:carousel) { Scraper.new('files/van-gogh-paintings.html').carousel }
  let(:parsed_painting_wrapper) { Parser.new(carousel.css('a').first) }
  let(:empty_carousel) { Scraper.new('files/van-gogh-paintings-empty.html').carousel }
  let(:parsed_empty_painting_wrapper) { Parser.new(empty_carousel.css('a').first) }

  let(:parsed_name) { carousel.css('a').first.attr('aria-label') }
  let(:parsed_image) { carousel.css('a').first.css('img').first.attr('src') }
  let(:parsed_link) { "https://google.com#{carousel.css('a').first.attr('href')}" }
  let(:parsed_extensions) { [carousel.css('a').first.attr('title')[/\((\d{4})\)/,1]] }


  describe '#painting_exists?' do
    context 'when carousel is present' do
      it 'returns name' do
        expect(parsed_painting_wrapper.painting_exists?).to be_truthy
      end
    end

    context 'when carousel is not present' do
      it 'returns nil' do
        expect(parsed_empty_painting_wrapper.painting_exists?).to be_falsey
      end
    end
  end

  describe '#name' do
    context 'when carousel is present' do
      it 'returns name' do
        expect(parsed_painting_wrapper.name).to eq(parsed_name)
      end
    end

    context 'when carousel is not present' do
      it 'returns nil' do
        expect(parsed_empty_painting_wrapper.name).to be_nil
      end
    end
  end

  describe '#image' do
    context 'when carousel is present' do
      it 'returns name' do
        expect(parsed_painting_wrapper.image).to eq(parsed_image)
      end

      it 'contains base64 image' do
        expect(parsed_painting_wrapper.image).to match(/data:image/)
      end
    end

    context 'when carousel is not present' do
      it 'returns nil' do
        expect(parsed_empty_painting_wrapper.image).to be_nil
      end
    end
  end

  describe '#link' do
    context 'when carousel is present' do
      it 'returns link' do
        expect(parsed_painting_wrapper.link).to eq(parsed_link)
      end
    end

    context 'when carousel is not present' do
      it 'returns nil' do
        expect(parsed_empty_painting_wrapper.link).to be_nil
      end
    end
  end

  describe '#extensions' do
    context 'when carousel is present' do
      it 'returns extensions' do
        expect(parsed_painting_wrapper.extensions).to eq(parsed_extensions)
      end

      it 'returns array' do
        expect(parsed_painting_wrapper.extensions).to be_a_kind_of(Array)
      end
    end

    context 'when carousel is not present' do
      it 'returns nil' do
        expect(parsed_empty_painting_wrapper.extensions).to be_nil
      end
    end
  end
end