require "parser"

describe Parser do
  it 'works for van gogh' do
    filename = 'files/van-gogh-paintings.html'
    truth_filename = 'files/expected-array.json'

    truth = JSON.parse("{" + open(truth_filename).read + "}")
    payload = Parser.parse_from_file(filename)

    expect(truth["artworks"]).to eq(payload)
  end

  it 'works for Louis Vuitton Bags' do
    filename = 'files/louis-vuitton-bags.html'

    payload = Parser.parse_from_file(filename)

    expect(payload.length).to eq(47)
    payload.each do |item|
      expect(item['name'].class).to eq(String)
      expect(item['link'].class).to eq(String)
      expect(item).to have_key('image')
      expect(item).to have_key('link')
    end
  end

  it 'works for Sarkodie Albums' do
    filename = 'files/sark-albums.html'
    payload = Parser.parse_from_file(filename)

    expect(payload.length).to eq(50)

    payload.each do |item|
      expect(item['name'].class).to eq(String)
      expect(item['link'].class).to eq(String)
      expect(item).to have_key('image')
      expect(item).to have_key('link')
    end
  end
end