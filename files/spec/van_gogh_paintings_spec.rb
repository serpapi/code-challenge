# spec/van_gogh_paintings_spec.rb
# Spec for testing results from van-gogh-paintings.rb

require "van-gogh-paintings"
require "json"

describe "Van Gogh Paintings Carousel Scrape" do

    before :all do
        @hash = van_gogh_carousel_scrape()
    end

    context "general tests" do

        it "returns anything" do
            expect(@hash).not_to be_nil
        end

        it "returns an array" do
            expect(@hash).to be_kind_of(Array)
        end

        it "returns a non-empty array" do
            expect(@hash.length()).to be > 0
        end

        it "returns an array of hashes" do
            expect(@hash.all?(Hash)).to be true
        end

        it "returns hashes with names" do
            expect(@hash.all? { |e| e.key?(:name)} ).to be true
        end

        it "hash names are all strings" do
            expect(@hash.all? { |e| e[:name].is_a?(String)} ).to be true
        end

        it "hash names are all non-empty" do
            expect(@hash.all? { |e| e[:name].length > 0} ).to be true
        end

        it "returns hashes with metadata extensions" do
            expect(@hash.all? { |e| e.key?(:extensions)} ).to be true
        end

        it "hash metadata extensions are all arrays" do
            expect(@hash.all? { |e| e[:extensions].is_a?(Array)} ).to be true
        end

        it "returns hashes with links" do
            expect(@hash.all? { |e| e.key?(:link)} ).to be true
        end

        it "hash links are all strings" do
            expect(@hash.all? { |e| e[:link].is_a?(String)} ).to be true
        end

        it "hash links are all non-empty" do
            expect(@hash.all? { |e| e[:link].length > 0} ).to be true
        end

        it "returns hash links that are all google search links" do
            expect(@hash.all? { |e| e[:link].start_with?('https://www.google.com/file:///search?')} ).to be true
        end

        it "returns hashes with image sources" do
            expect(@hash.all? { |e| e.key?(:img)} ).to be true
        end

        it "hash image sources are all strings (for those that exist)" do
            expect(@hash.all? { |e| e[:img].nil? || e[:img].is_a?(String) }).to be true
        end

        it "hash image sources are properly formatted (for those that exist)" do
            expect(@hash.all? { |e| e[:img].nil? || e[:img].start_with?('data:image/jpeg;base64') }).to be true
        end

        it "has an output that can generate a JSON object without failure" do
            expect{ JSON.generate(@hash) }.not_to raise_error
        end

    end


    context "specific tests" do

        it "returns an array of 51 hash objects" do
            expect(@hash.length).to eql(51)
        end

        it "45th object is named: Poppy Flowers" do
            expect(@hash[44][:name]).to eq("Poppy Flowers")
        end

        it "45th object is from: 1887" do
            expect(@hash[44][:extensions][0]).to eq("1887")
        end

        it "5th object has correct source link" do
            expect(@hash[4][:link]).to eq("https://www.google.com/file:///search?gl=us&hl=en&q=Caf%C3%A9+Terrace+at+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMyg2NLbSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhVzTkw7vFIhJLWoKDE5VSGxRMEvMz2jBACpuYkQsAAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIOw")   
        end

        it "20th object has correct source link" do
            expect(@hash[19][:link]).to eq("https://www.google.com/file:///search?gl=us&hl=en&q=Olive+Trees+(Van+Gogh+series)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHSs1KSc0u0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKV9c_JLEtVCClKTS1W0AhLzFNwz0_PUChOLcpMLdYEALQL__24AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIaA")
        end

    end

end