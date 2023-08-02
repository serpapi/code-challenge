require 'spec_helper'

RSpec.describe Parsers::GoogleCarousel do
  context 'when file could not be found' do
    let(:file_path) { Dir.pwd + '/spec/fixtures/google/wrong-path.html' }

    it 'throws the MissingFileError' do
      expect { Parsers::GoogleCarousel.new(file_path:) }.to raise_error(MissingFileError)
    end
  end

  context 'when file was found' do
    let!(:file_path) { Dir.pwd + '/spec/fixtures/google/van-gogh-paintings.html' }
    let!(:expected_json_path) { Dir.pwd + '/spec/fixtures/google/images.json' }
    let!(:expected_json) { JSON.parse(File.read(expected_json_path)) }

    subject(:result) { described_class.new(file_path:).call }

    it 'returns the same number of elements' do
      expect(result[:artworks].size).to eq(expected_json['artworks'].size)
    end

    it 'extensions field generates the same value' do
      expected_json['artworks'].each_with_index do |image_object, index|
        expect(result[:artworks][index][:extensions]).to eq(image_object['extensions'])
      end
    end

    it 'image field generates the same value' do
      expected_json['artworks'].each_with_index do |image_object, index|
        expect(result[:artworks][index][:image]).to eq(image_object['image'])
      end
    end

    it 'link field generates the same value' do
      expected_json['artworks'].each_with_index do |image_object, index|
        expect(result[:artworks][index][:link]).to eq(image_object['link'])
      end
    end

    it 'name field generates the same value' do
      expected_json['artworks'].each_with_index do |image_object, index|
        expect(result[:artworks][index][:name]).to eq(image_object['name'])
      end
    end
  end
end