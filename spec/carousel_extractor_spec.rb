require_relative '../carousel_extractor'
require 'spec_helper'

RSpec.describe CarouselExtractor do
  let!(:test_file_path) { './spec/van-gogh-paintings.html' }
  let!(:new_test_file_path) { './spec/van-gogh-paintings-new.html' }
  let!(:expected_json_array) { JSON.parse(File.read('./spec/expected-array.json')) }
  let!(:document) do
    CarouselExtractor.new(test_file_path).send(:document)
  end
  let!(:new_document) do
    CarouselExtractor.new(new_test_file_path).send(:document)
  end
  let!(:element) do
    document.css(CarouselExtractor::CAROUSEL_LOCATION).first
  end
  let!(:new_element) do
    new_document.css(CarouselExtractor::CAROUSEL_LOCATION).first
  end

  subject { described_class.new(test_file_path) }

  describe '#retrieve_name' do
    context 'when the element uses the aria-label attribute' do
      it 'should return the name' do
        expect(subject.send(:retrieve_name, element)).to eq 'The Starry Night'
      end
    end

    context 'when the element uses the title attribute' do
      it 'should return the name' do
        expect(subject.send(:retrieve_name, new_element)).to eq 'The Starry Night'
      end
    end

    context 'when neither is used' do
      before { new_element.remove_attribute('title') }
      it 'should raise an error' do
        expect do
          subject.send(:retrieve_name, new_element)
        end.to raise_error(CarouselExtractor::InvalidCarouselItemError)
      end
    end
  end

  describe '#retrieve_image' do
    context 'when parsing legacy files' do
      it 'should return the base64 of the img' do
        expect(subject.send(:retrieve_image, element)).to eq(
          expected_json_array['artworks'].first['image']
        )
      end
    end

    context 'when using latest files' do
      # The base64 is slightly different in the latest file
      it 'should return the base64 of the img' do
        service = described_class.new(new_test_file_path)
        expect(service.send(:retrieve_image, new_element)[0..50]).to eq(
          expected_json_array['artworks'].first['image'][0..50]
        )
      end
    end
  end

  describe '#retrieve_extensions' do
    context 'when using legacy files' do
      it 'should return the date' do
        expect(subject.send(:retrieve_extensions, element)).to eq(
          ['1889']
        )
      end
    end

    context 'when using latest files' do
      it 'should return the date' do
        expect(subject.send(:retrieve_extensions, new_element)).to eq(
          ['1889']
        )
      end
    end
  end

  describe '#extract' do
    it 'should extract the carousel items into a json array' do
      result = subject.extract
      expect(result.length).to eq 51
      expect(result.first).to eq(
        {
          name: expected_json_array['artworks'].first['name'],
          image: expected_json_array['artworks'].first['image'],
          link: expected_json_array['artworks'].first['link'],
          extensions: expected_json_array['artworks'].first['extensions']
        }
      )
    end
  end
end
