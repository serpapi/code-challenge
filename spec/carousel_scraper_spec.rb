require 'json'
require_relative '../lib/carousel_scraper'

RSpec.describe 'Carousel Scraper' do
  let(:files_path) { File.expand_path('../files', __dir__) }

  describe 'Van Gogh Paintings' do
    before :all do
      files_path = File.expand_path('../files', __dir__)
      html = File.read(File.join(files_path, 'van-gogh-paintings.html'))
      @result = CarouselScraper.new(html).extract
      @items = @result['artworks']
    end

    it 'returns a hash with artworks key' do
      expect(@result).to be_a(Hash)
      expect(@result).to have_key('artworks')
    end

    it 'extracts artworks array' do
      expect(@items).to be_an(Array)
      expect(@items).to_not be_empty
    end

    it 'artworks - name' do
      expect(@items[0][:name]).to be_a(String)
      expect(@items[0][:name]).to_not be_empty
    end

    it 'artworks - extensions' do
      expect(@items[0][:extensions]).to be_a(Array)
      expect(@items[0][:extensions]).to_not be_empty
    end

    it 'artworks - link' do
      expect(@items[0][:link]).to be_a(String)
      expect(@items[0][:link]).to_not be_empty
    end

    it 'artworks - image' do
      expect(@items[0][:image]).to be_a(String)
      expect(@items[0][:image]).to_not be_empty
    end

    it 'includes a known artwork' do
      names = @items.map { |a| a[:name] }.compact
      expect(names).to include('The Starry Night')
    end

    it 'does not include action tiles' do
      names = @items.map { |a| a[:name].to_s.downcase }
      expect(names).not_to include('more', 'show more', 'see more')
    end
  end

  describe 'David Bowie Albums' do
    before :all do
      files_path = File.expand_path('../files', __dir__)
      html = File.read(File.join(files_path, 'david-bowie-albums.html'))
      @result = CarouselScraper.new(html).extract
      @items = @result['albums']
    end

    it 'returns a hash with albums key' do
      expect(@result).to be_a(Hash)
      expect(@result).to have_key('albums')
    end

    it 'extracts albums array' do
      expect(@items).to be_an(Array)
    end

    it 'albums - name' do
      expect(@items[0][:name]).to be_a(String)
      expect(@items[0][:name]).to_not be_empty
    end

    it 'albums - link' do
      expect(@items[0][:link]).to be_a(String)
      expect(@items[0][:link]).to_not be_empty
    end

    it 'includes a known album' do
      names = @items.map { |a| a[:name] }.compact
      expect(names).to include('The Man Who Sold the World')
    end

    it 'does not include action tiles' do
      names = @items.map { |a| a[:name].to_s.downcase }
      expect(names).not_to include('more', 'show more', 'see more')
    end
  end

  describe 'Lord of the Rings Cast' do
    before :all do
      files_path = File.expand_path('../files', __dir__)
      html = File.read(File.join(files_path, 'lord-of-the-rings-cast.html'))
      @result = CarouselScraper.new(html).extract
      @items = @result['cast']
    end

    it 'returns a hash with cast key' do
      expect(@result).to be_a(Hash)
      expect(@result).to have_key('cast')
    end

    it 'extracts cast array' do
      expect(@items).to be_an(Array)
      expect(@items).to_not be_empty
    end

    it 'cast - name' do
      expect(@items[0][:name]).to be_a(String)
      expect(@items[0][:name]).to_not be_empty
    end

    it 'cast - link' do
      expect(@items[0][:link]).to be_a(String)
      expect(@items[0][:link]).to_not be_empty
    end

    it 'includes a known cast member' do
      names = @items.map { |a| a[:name] }.compact
      expect(names).to include('Elijah Wood')
    end

    it 'does not include action tiles' do
      names = @items.map { |a| a[:name].to_s.downcase }
      expect(names).not_to include('more', 'show more', 'see more')
    end
  end

  describe 'George Orwell Books' do
    before :all do
      files_path = File.expand_path('../files', __dir__)
      html = File.read(File.join(files_path, 'george-orwell-books.html'))
      @result = CarouselScraper.new(html).extract
      @items = @result['books']
    end

    it 'returns a hash with books key' do
      expect(@result).to be_a(Hash)
      expect(@result).to have_key('books')
    end

    it 'extracts books array' do
      expect(@items).to be_an(Array)
      expect(@items).to_not be_empty
    end

    it 'books - name' do
      expect(@items[0][:name]).to be_a(String)
      expect(@items[0][:name]).to_not be_empty
    end

    it 'books - link' do
      expect(@items[0][:link]).to be_a(String)
      expect(@items[0][:link]).to_not be_empty
    end

    it 'books - image' do
      expect(@items[0][:image]).to be_a(String)
      expect(@items[0][:image]).to_not be_empty
    end

    it 'includes a known book' do
      names = @items.map { |a| a[:name] }.compact
      expect(names).to include('Homage to Catalonia')
    end

    it 'does not include action tiles' do
      names = @items.map { |a| a[:name].to_s.downcase }
      expect(names).not_to include('more', 'show more', 'see more')
    end
  end

  describe 'Output format' do
    before :all do
      files_path = File.expand_path('../files', __dir__)
      html = File.read(File.join(files_path, 'van-gogh-paintings.html'))
      @result = CarouselScraper.new(html).extract
    end

    it 'produces valid JSON output' do
      expect { JSON.generate(@result) }.not_to raise_error
    end
  end
end
