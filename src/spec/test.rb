require "rspec"
require "../main.rb"

describe CarouselParser do
    before(:all) do
        parser = CarouselParser.new("../../files/van-gogh-paintings.html")
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

        it "'extensions' => Array should exist on every hash" do
            expect(@parsed).to all ( include("extensions" => be_an(Array)) )
        end

        it "'extensions' => Array should only have String elements on every hash" do
            expect(@parsed).to all satisfy { |hsh| hsh["extensions"].all? { |el| el.class == String } }
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

        it "'image' should be base64 encoded jpeg or nil on every hash" do
            expect(@parsed).to all satisfy { |hsh| hsh["image"].nil? | /^data:image\/jpeg;base64/.match?(hsh["image"]) }
        end
    end
end