require_relative '../lib/scrapers/google_search'

describe 'Google search old format' do

  describe 'Claude Monet artworks' do

    before(:all) do
      @search = GoogleSearch.new(q: 'monet')
      @results = @search.get_artworks
      @formatted_result = @search.get_artworks(formatted: true)
    end

    it 'has content' do
      content = @search.get_html
      expect(content).to be_a(String)
      expect(content).to_not be_empty
    end

    it 'has artworks' do
      expect(@results).to be_an(Array)
      expect(@results).to_not be_empty
    end

    it 'has all results with mandatory fields' do
      # extensions is missing if nothing found
      @results.each do |artwork|
        expect(artwork.keys).to include('name', 'link', 'image')
      end
    end

    it 'has expected number of results' do
      expect(@results.count).to be(7)
    end

    it 'has artwork entries with name' do
      name = @results[0]['name']
      expect(name).to be_a(String)
      expect(name).to_not be_empty
    end

    it 'has all artwork entries with clean name' do
      name = @results[0]['name']
      expect(name).to match(/\A[A-Za-z\s,-.]+\z/)
    end

    it 'has artwork entries with extentions' do
      ext = @results[0]['extensions']
      expect(ext).to be_a(Array)
      expect(ext).to_not be_empty
    end

    it 'has artwork entries with image' do
      ext = @results[0]['image']
      expect(ext).to be_a(String)
      expect(ext).to_not be_empty
    end

    it 'has artwork entries with no image found' do
      ext = @results[6]['image']
      expect(ext).to be(nil)
    end

    it 'has artwork entries with link' do
      ext = @results[0]['link']
      expect(ext).to be_a(String)
      expect(ext).to_not be_empty
    end

    it 'has a formatted results starting with "artworks"' do
      expect(@formatted_result).to be_a(String)
      expect(@formatted_result).to start_with('"artworks":')
    end

  end
end
