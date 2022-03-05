require 'json'

require_relative './main'

RSpec.describe GoogleParser do
  describe '#parse' do
    let(:path) { './files/van-gogh-paintings.html' }
    let(:parser) { described_class.new(path) }

    before do
      parser.parse
    end

    it 'parses first painting info successfully' do
      first_painting = parser.paintings.first
      expect(first_painting.name).to eq 'The Starry Night'
      expect(first_painting.extensions).to eq ['1889']
      expect(first_painting.link).to eq 'https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw'
      expect(first_painting.image).to be_start_with 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgH'
    end

    it 'parses pantings with the right data types' do
      expect(parser.paintings.size).to eq 51
      expect(parser.paintings)
        .to all(have_attributes(
                  name: be_a(String),
                  extensions: be(nil).or(be_a(Array)),
                  link: be_a(String).and(start_with('https://www.google.com')),
                  image: be(nil).or(be_a(String).and(start_with('data:image/jpeg;base64,')))
                ))
    end

    it 'matches with result' do
      result = parser.paintings.map(&:to_h)
      expect(result).to eq JSON.parse(File.read('./files/expected-array.json'), symbolize_names: true)[:artworks]
    end
  end
end
