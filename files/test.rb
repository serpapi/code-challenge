require 'rspec'
require './files/scrapper.rb'

describe 'Scrapper script' do
  before(:all) do
    scrapper = Scrapper.new('./files/van-gogh-paintings.html')
    @artworks = scrapper.carrousel_json
  end

  it 'should return an array' do
    expect(@artworks).to be_a(Array)
  end

  it 'should return an array without nil values' do
    expect(@artworks).to all(be_truthy)
  end

  it 'should return an array of hashes' do
    expect(@artworks).to all(be_a(Hash))
  end

  it 'should return a hash with a name key' do
    expect(@artworks).to all(include(:name))
    expect(@artworks.first[:name]).to be_a(String)
  end

  it 'should return a hash with a extensions key' do
    expect(@artworks).to all(include(:extensions))
    expect(@artworks.first[:extensions]).to be_a(Array)
  end

  it 'should return a hash with a link key' do
    expect(@artworks).to all(include(:link))
    expect(@artworks.first[:link]).to be_a(String)
  end

  it 'should return a hash with a image key' do
    expect(@artworks).to all(include(:image))
    expect(@artworks.first[:image]).to be_a(String)
  end
end
