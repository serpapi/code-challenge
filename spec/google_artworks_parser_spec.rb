require './lib/google_artworks_parser'
require 'json'

describe GoogleArtworksParser do
  before(:all) do
    @parser = GoogleArtworksParser.new('./files/van-gogh-paintings.html')
  end

  it 'Returns the content of the file as string' do
    expect(@parser.html).to be_a(String)
    expect(@parser.html).not_to be_empty
  end

  it 'Returns an array of image URLs' do
    expect(@parser.images).to be_an(Array)
    expect(@parser.images).not_to be_empty
    expect(@parser.images).to all(match(%r{^data:image/jpeg;base64,.+}))
  end

  it 'Returns a hash with artwork details' do
    expect(@parser.artworks).to be_a(Hash)
    expect(@parser.artworks[:artworks]).to be_an(Array)
    expect(@parser.artworks[:artworks].size).to eq 51
  end

  it 'Clears memorized values if the path has changed' do
    @parser.path = '/new/path/to/file.html'
    expect(@parser.path).to eq('/new/path/to/file.html')
    expect(@parser.instance_variable_get(:@html)).to be_nil
    expect(@parser.instance_variable_get(:@images)).to be_nil
  end
end
