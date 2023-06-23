require 'rspec'

RSpec.describe CarouselScraper::Scraper do
  let(:vg_html) { File.read('files/van-gogh-paintings.html') }
  let(:ns_html) { File.read('files/neal-stephenson-books.html') }
  let(:cn_html) { File.read('files/christopher-nolan-films.html') }

  let(:filename) { 'test-output.json' }

  context 'with van-gogh-paintings.html' do
    subject(:scraper) { described_class.new(vg_html) }
    let(:fixture) { File.read('spec/fixtures/van_gogh_artwork.json') }

    it_behaves_like 'a carousel scraper'
  end

  context 'with neal-stephenson-books.html' do
    subject(:scraper) { described_class.new(ns_html) }
    let(:fixture) { File.read('spec/fixtures/neal_stephenson_book.json') }

    it_behaves_like 'a carousel scraper'
  end

  context 'with christopher-nolan-films.html' do
    subject(:scraper) { described_class.new(cn_html) }
    let(:fixture) { File.read('spec/fixtures/christopher_nolan_film.json') }

    it_behaves_like 'a carousel scraper'
  end
end
