require 'rspec'
require 'pry'
require_relative '../lib/artwork_extractor'

describe ArtworkExtractor do

  let(:van_gogh_paitings) { File.read("files/van-gogh-paintings.html") }

  subject { ArtworkExtractor.new(van_gogh_paitings) }

  it 'has an html atrribute starting with the html tag' do
    expect(subject.html[0...5]).to eq('<html')
  end

  it 'extract the artwork names from the html' do
    expect(subject.extract_names.size).to eq(51)
    expect(subject.extract_names.first).to eq('The Starry Night')
    expect(subject.extract_names.last).to eq('Portrait of Adeline Ravoux')
  end

end