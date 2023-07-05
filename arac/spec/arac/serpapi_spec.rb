# frozen_string_literal: true

require 'arac'

RSpec.describe 'SerpApi' do
  let(:html) { File.read(File.join(File.dirname(__FILE__), 'fixtures', 'van-gogh-paintings.html')) }

  before do
    arac = Arac.new do
      items :artworks, selector: 'div.klitem-tr' do
        item :name, selector: 'div.kltat', methods: [[:text], [:strip], [:gsub, "\n", '']]
        item :extensions, selector: 'div.klmeta', methods: [[:text], [:split, ' ']]
        item :link, selector: 'a', methods: [[:attr, 'href'], [:prepend, 'https://www.google.com']]
        item :image, selector: 'g-img > img', methods: [[:attr, 'src']]
      end
    end
    @json = arac.capture_from(html)
  end

  it 'artworks' do
    expect(@json[:artworks]).to be_a(Array)
    expect(@json[:artworks]).to_not be_empty
  end

  it 'artworks - name' do
    expect(@json[:artworks][0][:name]).to be_a(String)
    expect(@json[:artworks][0][:name]).to_not be_empty
  end

  it 'artworks - extensions' do
    expect(@json[:artworks][0][:extensions]).to be_a(Array)
    expect(@json[:artworks][0][:extensions]).to_not be_empty
  end

  it 'artworks - link' do
    expect(@json[:artworks][0][:link]).to be_a(String)
    expect(@json[:artworks][0][:link]).to_not be_empty
  end

  it 'artworks - image' do
    expect(@json[:artworks][0][:image]).to be_a(String)
    expect(@json[:artworks][0][:image]).to_not be_empty
  end
end
