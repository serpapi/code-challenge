require_relative '../carousel_parser'
require 'rspec'

HTMLS = {
  artworks: File.expand_path(File.join(__dir__, '../../van-gogh-paintings.html')),
  cast: File.expand_path(File.join(__dir__, '../../dune-actors.html')),
  albums: File.expand_path(File.join(__dir__, '../../eminem-albums.html'))
}

RSpec.describe CarouselParser do
  before do
    # currently to test different HTML, HTMLS[key] should be changed manually.
    @carousel_parser = CarouselParser.get_carousel(HTMLS[:artworks])
  end

  it 'should return a Hash' do
    expect(@carousel_parser).to be_an(Hash)
  end

  it "which shouldn't be empty" do
    expect(@carousel_parser.length).not_to eq(0)
  end

  it 'should contain an Array inside of a Hash' do
    expect(@carousel_parser.values[0]).to be_an(Array)
  end

  it "which shouldn't be empty" do
    expect(@carousel_parser.values[0].length).not_to eq(0)
  end

  it 'should contain a Hash inside of an Array' do
    expect(@carousel_parser.values[0][0]).to be_an(Hash)
  end

  it "which shouldn't be empty" do
    expect(@carousel_parser.values[0][0].length).not_to eq(0)
  end

  describe 'Hash should have the following structure:' do
    {
      title: String,
      link: String,
      extentions: Array,
      thumbnail: String
    }.each_with_index do |(key, value), index|
      it "#{index + 1}. Has #{key}" do
        expect(@carousel_parser.values[0][0][key]).to be_a_kind_of(value)
      end
    end
  end
end
