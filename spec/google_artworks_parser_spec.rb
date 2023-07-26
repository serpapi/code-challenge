require './lib/google_artworks_parser'
require 'json'

# to remove code duplication
shared_examples 'Artwork details' do
  it 'Returns a hash with artwork details' do
    expect(@parser.get_results).to be_a(Hash)
    expect(@parser.get_results[:artworks]).to be_an(Array)
    expect(@parser.get_results[:artworks]).not_to be_empty

    @parser.get_results[:artworks].each do |artwork|
      if artwork[:extensions]
        expect(artwork.keys).to contain_exactly(:name, :extensions, :link, :image)
      else
        expect(artwork.keys).to contain_exactly(:name, :link, :image)
      end
    end
  end
end

describe GoogleArtworksParser do
  before(:all) do
    @parser = GoogleArtworksParser.new('./files/van-gogh-paintings.html')
  end

  it 'Returns the content of the file as string' do
    expect(@parser.get_html).to be_a(String)
    expect(@parser.get_html).not_to be_empty
  end

  it 'Returns an array of image URLs' do
    expect(@parser.get_images).to be_an(Array)
    expect(@parser.get_images).not_to be_empty

    @parser.get_images.each do |image|
      next if image.nil?
      expect(image).to match(%r{^data:image/jpeg;base64,.+})
    end
  end

  it 'Clears memorized values if the path has changed' do
    @parser.path = './files/picasso-paintings.html'
    expect(@parser.path).to eq('./files/picasso-paintings.html')
    expect(@parser.instance_variable_get(:@html)).to be_nil
    expect(@parser.instance_variable_get(:@doc)).to be_nil
    expect(@parser.instance_variable_get(:@images)).to be_nil
  end

  it 'Returns an error message if no artworks are found' do
    @parser.path = './files/coffee.html'
    expect(@parser.get_results).to eq({ error: 'There are no artworks matching the specified criteria.' })
  end

  describe 'Supports old Google search engine structure' do
    before(:each) do 
      @parser.path = './files/van-gogh-paintings.html'
    end
    
    include_examples 'Artwork details'
  end

  describe 'Supports new Google search engine structure' do
    before(:each) do 
      @parser.path = './files/van-gogh-paintings-new.html'
    end

    include_examples 'Artwork details'
  end
end