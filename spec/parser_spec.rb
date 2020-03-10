# frozen_string_literal: true

require_relative '../parser'

describe 'Parser class tests for Da Vinci Paintings' do
  before :all do
    p = Parser.new('files/da-vinci-paintings.html')
    p.extract_artworks
    @json = JSON.parse(p.extract_artworks)
  end

  it 'contains objects in array' do
    expect(@json).to_not be_empty
  end

  it 'name' do
    expect(@json.first['name']).to be_a(String)
    expect(@json.first['name']).to_not be_empty
  end

  it 'extensions' do
    expect(@json.first['extensions']).to be_a(Array)
    expect(@json.first['extensions']).to_not be_empty
  end

  it 'link' do
    expect(@json.first['link']).to be_a(String)
    expect(@json.first['link']).to_not be_empty
  end

  it 'image' do
    expect(@json.first['image']).to be_a(String)
    expect(@json.first['image']).to_not be_empty
  end
end
