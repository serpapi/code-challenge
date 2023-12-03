require_relative '../google_search'

describe GoogleSearch do
    let(:expected) { JSON.parse(File.read('./files/expected-array.json'))['artworks'] }

    describe 'get_artworks' do
        it 'should return all artworks if file is correct' do
            File.stub(:extname).and_return('.html')

            google_search = GoogleSearch.new
            expect(google_search.get_artworks(File.read('./files/van-gogh-paintings.html'))).to eq(expected)
        end

        it 'should return error if file is not html' do
            File.stub(:extname).and_return('.png')
            google_search = GoogleSearch.new
            expect {
                google_search.get_artworks(File.read('./files/van-gogh-paintings.png'))
            }.to raise_exception(Exception, 'Please provide html file')
        end
    end
end