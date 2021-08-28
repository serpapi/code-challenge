require 'spec_helper'
require_relative "../../../lib/page_search"
require_relative "../../../lib/google/carousel_extractor"

describe Google::CarouselExtractor do
  file = File.open('./files/van-gogh-paintings.html')
  search = PageSearch.new(file, 'div.EDblX.DAVP1 div.MiPcId.klitem-tr.mlo-c a').search

  subject { described_class.new(search).extract }

  it 'should return an array' do
    expect(subject).to be_an(Array)
  end

  it 'should have correct keys' do
    hash_keys = [:name, :extensions, :link, :image]
    expect(subject[0].keys).to contain_exactly(*hash_keys)
  end
end
