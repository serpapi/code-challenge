require "rspec"
require_relative "code.rb"

RSpec.describe ArtParser do

  let(:parser) { ArtParser.new }
  let(:result) { parser.parse(path="./files/van-gogh-paintings.html") }

  it "returns non null result" do
    # puts(result)
    expect(result.class).not_to eq nil
  end

  it "returns hashmap" do
    # puts(result)
    expect(result.class).to eq Hash
  end

  it "has artworks key" do
    expect(result.has_key? ("artworks")).not_to eq false
  end

  it "has non-null value for artworks key" do
    expect(result["artworks"]).not_to eq nil
  end

  it "artworks value is an Array" do
    expect(result["artworks"].class).to eq Array
  end

  it "has non-zero results" do
    expect(result["artworks"].length).not_to eq 0
  end

  it "has 4 keys for each artwork" do
    expect(result["artworks"][0].size).to eq 4
  end

  it "parses result correctly" do
    artwork = result["artworks"][0]
    # puts(artwork)
    expect(artwork["name"]).to eq "The Starry Night"
    expect(artwork["extensions"][0]).to eq "1889"
  end

  it "has correct classtype for: name" do
    name = result["artworks"][0]["name"]
    expect(name.class).to eq String
  end

  it "has correct classtype for: extensions" do
    extensions = result["artworks"][0]["extensions"]
    expect(extensions.class).to eq Array
  end
  it "has correct classtype for: link" do
    link = result["artworks"][0]["link"]
    expect(link.class).to eq String
  end

  it "has correct classtype for: image" do
    image = result["artworks"][0]["image"]
    expect(image.class).to eq String
  end

end
