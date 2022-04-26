require 'json'

require_relative './main'

RSpec.describe 'GoogleParser' do
  describe '#parse' do
    let(:parser) { GoogleParser.new(path) }

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

    context 'sark-albums carousel' do
      let(:path) { './files/sark-albums.html' }

      it 'parses first album info successfully' do
        first_album = parser.paintings.first
        expect(first_album.name).to eq 'No Pressure'
        expect(first_album.extensions).to eq ['2021']
        expect(first_album.link).to eq 'https://www.google.com/search?rlz=1C5CHFA_enUS886US887&sxsrf=APq-WBujEUds0UcgKtqrqQ-e6BZeCDbo2A:1650583503382&q=Sarkodie+NO+PRESSURE&stick=H4sIAAAAAAAAAONgFuLSz9U3KDSuNKxMV-LVT9c3NCy0NCw0MU6v0hLPTrbSzy0tzkzWTywqySwusUrMSSrNLV7EKhKcWJSdn5KZquDnrxAQ5BocHBrkCgDJ-0KwTQAAAA&sa=X&ved=2ahUKEwipmpDbpqb3AhURkIkEHYoQCzUQ9OUBegQIHBAD'
        expect(first_album.image).to be_start_with 'data:image/jpeg;base64,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'
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

    context 'louis-vuitton-bag' do
      let(:path) { './files/louis-vuitton-bags.html' }

      it 'parses first bag info successfully' do
        first_book = parser.paintings.first
        expect(first_bag.name).to eq 'Pochette'
        expect(first_bag.extensions).to eq ['Mini Pochette']
        expect(first_bag.link).to eq 'https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwiD1Y7-qKb3AhWl8OMHHaX5AHgYABANGgJ5bQ&ohost=www.google.com&cid=CAESbOD26QDgbs_Uw9P862bCVGCzNVHFa3FWM5awEVpRFuiFR9C6gd8V0epsPMvmNVbR9AeNp0MuFcMHx4jtFPghGUaebziBwlYbpiFp-UyY1rfGi6GeAnSOMXY5VwpM-UuzgaFkxz-T-E5D5DC2lA&sig=AOD64_1S9SYTo-t7xZBmZXv2ByoMUNWRWg&ctype=5&q=&ved=2ahUKEwiq4v79qKb3AhX4hYkEHeHmDsIQ9aACegQIARBA&adurl='
        expect(first_bag.image)
          .to be_start_with 'data:image/jpeg;base64,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'
      end

      it 'parses bags with the right data types' do
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