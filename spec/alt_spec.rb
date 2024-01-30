require_relative "../alt"
require "json"

describe "Artworks for Van Gogh Paintings (Alt)" do
	before :all do
		@hash = parse_artworks(
			get_html("alt-van-gogh-paintings")
		)
		@json = JSON.parse(@hash)
	end

	it "is hash" do
		expect(@json).to be_an(Hash)
	end

	it "artworks" do
		expect(@json["artworks"]).to be_a(Array)
		expect(@json["artworks"]).to_not be_empty
	end

	it "artworks - name" do
		expect(@json["artworks"][0]["name"]).to be_a(String)
		expect(@json["artworks"][0]["name"]).to_not be_empty
	end

	it "artworks - extensions" do
		expect(@json["artworks"][0]["extensions"]).to be_a(Array)
		expect(@json["artworks"][0]["extensions"]).to_not be_empty
	end

	it "artworks - link" do
		expect(@json["artworks"][0]["link"]).to be_a(String)
		expect(@json["artworks"][0]["link"]).to_not be_empty
	end

	it "artworks - image" do
		expect(@json["artworks"][0]["image"]).to be_a(String)
		expect(@json["artworks"][0]["image"]).to_not be_empty
	end
end