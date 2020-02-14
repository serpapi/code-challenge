require 'rspec'
require 'pry'
require_relative '../lib/artwork_extractor'

describe ArtworkExtractor do

  let(:van_gogh_paitings) { File.read("files/van-gogh-paintings.html") }

  subject { ArtworkExtractor.new(van_gogh_paitings) }

  it 'has an html atrribute starting with the html tag' do
    expect(subject.html[0...5]).to eq('<html')
  end

  it 'extracts the artwork names from each card' do
    expect(subject.extract_names.size).to eq(51)
    expect(subject.extract_names.first).to eq('The Starry Night')
    expect(subject.extract_names.last).to eq('Portrait of Adeline Ravoux')
  end

  it 'extracts 51 artwork links from the cards' do
    expect(subject.extract_links.size).to eq(51)
  end

  it 'extracts the first link from the card' do
    expect(subject.extract_links.first).to eq('https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw')
  end

  xit 'extract the extensions from each card' do
    pending
  end

end