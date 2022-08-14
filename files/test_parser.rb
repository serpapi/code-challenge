
require "rspec/autorun"

require_relative './van-gough-parse.rb'


describe "Van Gogh Paintings" do

  before :all do
    @parser = GoogleCarouselParser.new
    @result = @parser.parse
  end

  it "includes artworks key" do
    expect(@result).to have_key(:artworks)
  end

  it "contains artworks array" do
    expect(@result[:artworks]).to be_an(Array)
    expect(@result[:artworks]).to_not be_empty
  end

  it "artworks - name" do
    expect(@result[:artworks][0][:name]).to be_a(String)
    expect(@result[:artworks][0][:name]).to_not be_empty
  end

  it "artworks - extensions" do
    expect(@result[:artworks][0][:extensions]).to be_a(Array)
    expect(@result[:artworks][0][:extensions]).to_not be_empty
  end

  it "artworks - link" do
    expect(@result[:artworks][0][:link]).to be_a(String)
    expect(@result[:artworks][0][:link]).to_not be_empty
  end

  it "artworks - image" do
    expect(@result[:artworks][0][:image]).to be_a(String)
    expect(@result[:artworks][0][:image]).to_not be_empty
  end

end

