require "parser"

describe Parser do
    
    describe "Extract Van Gogh paintings" do

        before :all do
            @parser = Parser.new('van-gogh-paintings.html')
            @parser.extract_carousel()
            @results = @parser.get_carousel_results()
            @carousel_type = @parser.get_carousel_type()
        end

        it "contains results hash" do
            expect(@results).to be_instance_of(Hash)
        end

        it "contains carousel type" do
            expect(@carousel_type).to be_instance_of(String)
        end

        it "artworks - name" do
            expect(@results[@carousel_type.to_sym][0][:name]).to be_instance_of(String)
            expect(@results[@carousel_type.to_sym][0][:name]).not_to be_empty
        end

        it "artworks - extensions" do
            expect(@results[@carousel_type.to_sym][0][:extensions]).to be_instance_of(Array)
            expect(@results[@carousel_type.to_sym][0][:extensions]).not_to be_empty
        end

        it "artworks - link" do
            expect(@results[@carousel_type.to_sym][0][:link]).to be_instance_of(String)
            expect(@results[@carousel_type.to_sym][0][:link]).not_to be_empty
        end

        it "artworks - image" do
            expect(@results[@carousel_type.to_sym][0][:image]).to be_instance_of(String)
            expect(@results[@carousel_type.to_sym][0][:image]).not_to be_empty
        end
    end
end