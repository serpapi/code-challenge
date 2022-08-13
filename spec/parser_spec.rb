require 'json'

describe "Parser" do
    describe "Van Gogh Paitings" do
        before :all do
            @file = File.read('files/van-gogh-paintings.json')
            @data = JSON.parse(@file)
        end 

        it 'contains 51 elements' do
            expect(@data.length).to eq(51)
        end 

        it 'last element image' do
            expect(@data.last["image"]).to eq("null")
        end
    end

    describe "Matthew mcconaughey Movies" do
        before :all do
            @file = File.read('files/matthew-mcconaughey-movies.json')
            @data = JSON.parse(@file)
        end 

        it 'contains 51 elements' do
            expect(@data.length).to eq(51)
        end

        it 'last element image' do
            expect(@data.last["image"]).not_to eq("null")
        end
        
    end

    describe "Premier League teams" do
        before :all do
            @file = File.read('files/premier-league-teams.json')
            @data = JSON.parse(@file)
        end 

        it 'contains 51 elements' do
            expect(@data.length).to eq(51)
        end

        it 'last element image' do
            expect(@data.last["image"]).to eq("null")
        end
        
    end

    describe "Matt Damon Movies" do
        before :all do
            @file = File.read('files/matt-damon-movies.json')
            @data = JSON.parse(@file)
        end 

        it 'contains 82 elements' do
            expect(@data.length).to eq(82)
        end

        it 'last element image' do
            expect(@data.last["image"]).to eq("null")
        end
        
    end
end