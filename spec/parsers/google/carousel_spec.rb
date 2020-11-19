# frozen_string_literal: true

RSpec.describe Google::Carousel do
  # NOTE: Absolute path in chrome container
  TEST_FILE_PATHS = [
    'file:///tmp/files/van-gogh-paintings.html',
    'file:///tmp/files/pink-floyd-albums.htm',
    'file:///tmp/files/led-zeppelin-albums.htm'
  ].freeze

  TEST_FILE_PATHS.each do |file_path|
    # TODO: Better to test all possible cases (ex. extensions absent)
    subject(:parsed_carousel) { described_class.new(path: file_path).as_json.first }

    it 'parse name properly' do
      expect(parsed_carousel[:name]).to be_a(String)
      expect(parsed_carousel[:name]).not_to be_empty
    end

    it 'parse extensions properly' do
      expect(parsed_carousel[:extensions]).to be_a(Array)
      expect(parsed_carousel[:extensions]).not_to be_empty
    end

    it 'parse link properly' do
      expect(parsed_carousel[:link]).to be_a(String)
      expect(parsed_carousel[:link]).not_to be_empty
    end

    it 'parse image properly' do
      expect(parsed_carousel[:image]).to be_a(String)
      expect(parsed_carousel[:image]).to start_with('data:image/jpeg;base64')
      expect(parsed_carousel[:image]).not_to be_empty
    end
  end
end
