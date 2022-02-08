require_relative '../scraper'
require 'rspec'

def get_file_path(filename)
  File.expand_path(File.join(File.dirname(__FILE__) , filename))
end

artworks = get_file_path("../files/van-gogh-paintings.html")
books = get_file_path("../files/shakespeare-books.html")
buildings = get_file_path("../files/tallest-building.html")

RSpec.describe Scraper do
  before do
    scraper = Scraper.new
    @html_parser = scraper.parse_HTML(artworks)
  end

  it 'should return an Array' do
    expect(@html_parser).to be_an(Array)
  end

  it "should not be an empty Array" do
    expect(@html_parser.length).not_to eq(0)
  end

  it 'should contain an Object inside of the Array' do
    expect(@html_parser[0]).to be_an(Object)
  end

  it "should contain a String for the 'name' key" do
    expect(@html_parser[0][:name]).to be_an(String)
  end

  it "should contain an Array for the 'extention' key" do
    expect(@html_parser[0][:extentions]).to be_an(Array)
  end

  it "should contain a String value for the 'link' key" do
    expect(@html_parser[0][:link]).to be_an(String)
  end

  it "should contain a String value for the 'image' key" do
    expect(@html_parser[0][:image]).to be_an(String)
  end
end