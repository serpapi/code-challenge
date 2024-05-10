require "rspec"
require "../main.rb"

describe CarouselParser do
    before(:all) do
        parser = CarouselParser.new("van-gogh-paintings.html")
        parser.parse
        @parsed = parser.parsed
    end

    # Tests
    describe "Object shape" do
        it "The parsed result should be an array" do
            expect(@parsed).to be_an(Array)
        end

        it "The parsed array should not be empty" do
            expect(@parsed.size).to be > 0
        end

        it "'name' => String should exist on every hash" do
            expect(@parsed).to all ( include("name" => be_a(String)) )
        end

        it "If 'extensions' exists on a hash it should be an Array" do
            expect(@parsed).to all satisfy { |hsh| ! hsh.key?("extensions") || hsh["extensions"].class == Array }
        end

        it "If 'extensions' exists on a hash it should only have String elements" do
            expect(@parsed).to all satisfy { |hsh| ! hsh.key?("extensions") || hsh["extensions"].all? { |el| el.class == String } }
        end

        it "'link' => String should exist on every hash" do
            expect(@parsed).to all ( include("link" => be_a(String)) )
        end

        it "'image' => String | nil should exist on every hash" do
            expect(@parsed).to all ( include("image" => be_a(String) | be_nil) )
        end
    end

    describe "Object content" do
        it "'link' should be an HTTPS www.google.com/search link on every hash" do
            expect(@parsed).to all satisfy { |hsh| /^https:\/\/www.google.com\/search/.match?(hsh["link"]) }
        end

        it "'image' should be base64 encoded or nil on every hash" do
            expect(@parsed).to all satisfy { |hsh| hsh["image"].nil? | /^data:image\/.*?;base64/.match?(hsh["image"]) }
        end
    end
end