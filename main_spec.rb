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
        expect(first_album.image).to be_start_with 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjcl'
      end

      it 'parses albums with the right data types' do
        expect(parser.paintings.size).to eq 41
        expect(parser.paintings)
          .to all(have_attributes(
                    name: be_a(String),
                    extensions: be(nil).or(be_a(Array)),
                    link: be_a(String).and(start_with('https://www.google.com')),
                    image: be(nil).or(be_a(String).and(start_with('data:image/jpeg;base64,')))
                  ))
      end
    end

    context 'ruby-book' do
      let(:path) { './files/ruby-book.html' }

      it 'parses first book info successfully' do
        first_book = parser.paintings.first
        expect(first_book.name).to eq 'Ruby'
        expect(first_book.extensions).to eq ['Cynthia Bond, 2014']
        expect(first_book.link).to eq 'https://www.google.com/search?q=Ruby&stick=H4sIAAAAAAAAAFVTPWzTQBi1U5o41wKJAxLKQkkXiECJfxOmVPxIILWqKB1gsnIX_8S-sx3bxHEWBGJBYigMlWCgEgsMbCyIAaJuZAAJpI6oYmOBFZUBEhTbML5797733qc7Zr6yWNNrnInrhh5YMp_3bsFoCTqONab_Y2aQh3ZDOo_ImM7XSK0umNYQJRQxNQULYxpMKTEiDU8c04enHIc419NRFMV3UU9QfIFLpRoy-1YKDdnnUrGshLChSTHWLai50NZnTnyIB0SISdvu69jrkNksTvA5MnGOaUNoYiPo4TSYzw2Cnpn2s5DBe7PREocUS09j8RPSjKUw1AJiyUlM2Og1hwKB6ehQ8zuDJBniXRcNm36MrYYY8P7wnyiSIiMIEzs3lIYinq266eI-ia9qnOeaYZBswMKi6CWNPU_ne7GuY8iEpBa2LRHDSLDEa1qzj5K5YajUBWx_pZ9kFgrffn4plbcyj16-36PvZ0Bh1XF8FUcbKm4HamfTYc-C7GU76AYRu1gGgJnawYEn8sfArKE82Ven6RZ29rdp9hpYuK4Gm86a0-lqEXuBXQH5NZVA1fPXNXYZgIsOxioKuo7NHi-XQLGGkoPa9En6lSMbfzvBQEHCiM5UPF5582n7Q_Zm8fUlirrxan2lfKbKgtxVf9VBbVw8ufyYOXen2qqWALPZHji2Q6LivSvff3_c_9GqnMo_zf3aebg7ahWfV49SD27PjU7MLVGnKe7zXm4_qxy8q1ITl7tvX-xmGYYuUHyGoYbU4rP5QxuTb7KVpf8AutQtn0ADAAA&sa=X&ved=2ahUKEwiCl_fGzK72AhV0k1YBHaKTBt0Q-BZ6BAgvEAY'
        expect(first_book.image)
          .to be_start_with 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Oj'
      end

      it 'parses albums with the right data types' do
        expect(parser.paintings.size).to eq 34
        expect(parser.paintings)
          .to all(have_attributes(
                    name: be_a(String),
                    extensions: be(nil).or(be_a(Array)),
                    link: be_a(String).and(start_with('https://www.google.com')),
                    image: be(nil).or(be_a(String).and(start_with('data:image/jpeg;base64,')))
                  ))
      end
    end
  end
end
