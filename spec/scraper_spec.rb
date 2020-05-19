# frozen_string_literal: true

require_relative '../scraper'

describe Scraper do
  define_example_method :they

  [
    [FileURI.new('files/van-gogh-paintings.html'), 51],
    [FileURI.new('files/van-gogh-paintings-updated.html'), 48],
    [FileURI.new('files/michelangelo.html'), 46],
    [FileURI.new('files/rembrandt.html'), 50]
  ].each do |(path, expected_items_count)|
    context "for #{path}" do
      before :all do
        @data = Scraper.run(path)
      end

      subject(:artworks) { @data[:artworks] }

      it 'contains all artworks' do
        expect(artworks.size).to eq(expected_items_count)
      end

      they 'all have names' do
        expect(artworks).to all(include(name: String))
      end

      they 'all have links' do
        expect(artworks).to all(include(link: a_string_matching(/search\?/)))
      end

      they 'sometimes have extensions containing year' do
        expect(artworks).to all(include(extensions: include(a_string_matching(/\d{1,4}/)).or(be_empty)))
        expect(artworks.any? { |artwork| !artwork[:extensions].empty? }).to be true
      end

      they 'sometimes have images' do
        expect(artworks).to all(include(image: a_string_starting_with('data:image')
                                          .or(a_string_starting_with('https://'))
                                          .or(be_nil)))

        expect(artworks.any? { |artwork| !artwork[:image].empty? }).to be true
      end
    end
  end
  context 'when there are no artworks' do
    before :all do
      @data = Scraper.run(FileURI.new('files/serp-api.html'))
    end

    subject(:artworks) { @data[:artworks] }

    it { is_expected.to be_empty }
  end
end
