require 'json'

require_relative './main'

RSpec.describe GoogleParser do
  describe '#parse' do
    let(:parser) { described_class.new(path) }

    before do
      parser.parse
    end

    context 'van-gogh-paintings' do
      let(:path) { './files/van-gogh-paintings.html' }

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

    context 'john-lenon-albums carousel' do
      let(:path) { './files/john_lennon_albums.html' }

      it 'parses first album info successfully' do
        first_album = parser.paintings.first
        expect(first_album.name).to eq 'Imagine'
        expect(first_album.extensions).to eq ['1971']
        expect(first_album.link).to eq 'https://www.google.com/search?q=John+Lennon+Imagine&stick=H4sIAAAAAAAAAONgFuLSz9U3MCwrzjGOV4KwM3Jz86q0xLOTrfRzS4szk_UTi0oyi0usEnOSSnOLHzH-YOQWePnjnrDUO8ZJa05eY3zOyIVLsZAeF5trXklmSaUQnxQPF5JdRiJcvPrp-oaG2WbZSeY5yYYCe39MZVSazGiUsevStHNsSYLPQhkY5IzDHKSMBFnX2Xtlv3pvryXExe5Z7JOfnJgjqMxj7bD7J1BMmIsjJLEiPy8_t1JwptbF_R6_39srKXLmPzZlMLrz3l5w0WOGhu-3HBwkWBQYNBgMH1myOqyfwnhAiyGIG-wcQ4siU6PKIE4QxyinwqjoACNT074Vh9g4OBgFGIyYOBismDSYqoA0zyJWYa_8jDwFn9S8vPw8Bc_cxPTMvNQJbIwA9ej8RUgBAAA&sa=X&ved=2ahUKEwjEncDMwq72AhU_QPUHHW5-CxYQ-BZ6BAgnEA4&tbs=kac:1,kac_so:0'
        expect(first_album.image).to be_start_with 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkI'
      end
    end
  end
end
