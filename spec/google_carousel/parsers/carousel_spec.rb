require 'rspec_helper'

describe GoogleCarousel::Parsers::Carousel do
  before do
    raw_html = File.read('files/van-gogh-paintings.html')
    @result = described_class.new(raw_html).parse
  end

  it 'parses the carousel item - name correctly' do
    expect(@result).not_to be_empty
    expect(@result.keys).to eq(['artworks'])
  end
end
