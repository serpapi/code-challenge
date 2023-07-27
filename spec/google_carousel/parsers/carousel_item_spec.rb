require 'rspec_helper'

describe GoogleCarousel::Parsers::CarouselItem do
  before do
    raw_html = File.read('files/van-gogh-paintings.html')
    doc = Nokolexbor::HTML(raw_html.encode('utf-8'))

    content = nil
    doc.at_css('g-scrolling-carousel').traverse do |x|
      if (x.name == 'a')
        content = x
        break
      end
    end

    @item = described_class.new(content)
  end

  it 'parses the carousel item - name correctly' do
    expect(@item.name).not_to be_empty
  end

  it 'parses the carousel item - link correctly' do
    expect(@item.link).not_to be_empty
  end

  it 'parses the carousel item - extensions correctly' do
    expect(@item.extensions).not_to be_empty
  end

  it 'parses the carousel item - img_id correctly' do
    expect(@item.img_id).not_to be_empty
  end
end
