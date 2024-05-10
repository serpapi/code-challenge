require "rspec"
require_relative "../main.rb"

describe CarouselParser do
    before(:all) do
        # Run the parser
        parser = CarouselParser.new("van-gogh-paintings.html")
        parser.parse
        @parsed = parser.get_obj

        # Store both the expected JSON and output JSON
        expected_json_path = File.expand_path("../../files/expected-array.json", File.dirname(__FILE__))
        @expected_json = JSON.parse(File.read(expected_json_path)[12..])
        @output_json = JSON.parse(parser.get_json) # this should be identical to @parsed if we trust the JSON module
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

    describe "Direct expected JSON comparison" do
        it "'name' of every hash is identical between expected and output" do
            expect(@output_json).to all satisfy { |hsh|
                @expected_json.find { |e_hsh| e_hsh["name"] == hsh["name"] }
            }
        end

        it "'extensions' of every hash is identical between expected and output" do
            expect(@output_json).to all satisfy { |hsh|
                expected_hash = @expected_json.find { |e_hsh| e_hsh["name"] == hsh["name"] }
                return false unless expected_hash
                hsh["extensions"] == expected_hash["extensions"] 
            }
        end

        it "'link' of every hash is identical between expected and output" do
            expect(@output_json).to all satisfy { |hsh|
                expected_hash = @expected_json.find { |e_hsh| e_hsh["name"] == hsh["name"] }
                return false unless expected_hash
                hsh["link"] == expected_hash["link"]
            }
        end

        it "'image' of every hash is identical between expected and output" do
            expect(@output_json).to all satisfy { |hsh|
                expected_hash = @expected_json.find { |e_hsh| e_hsh["name"] == hsh["name"] }
                return false unless expected_hash
                hsh["image"] == expected_hash["image"] 
            }
        end
    end

end