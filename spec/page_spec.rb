require './page'

describe "Google search results page parser" do
  [
    'american-novels.html',
    'ruby-rail-book.html',
    'van-gogh-paintings.html',
  ].each do |file|
    describe "Parse file: files/#{file}" do
      
      before :all do
        @artworks = JSON.parse(Page.new(File.dirname(__FILE__) + "/../files/#{file}").parse())
      end

      it "Should have artworks parsed" do
        expect(@artworks).to be_an_instance_of(Array)
        expect(@artworks.length).to be > 0
      end

      describe "Artworks results" do
        
        it "Has a string name" do
          name = @artworks[0]["name"]
          expect(name).to be_an_instance_of(String)
          expect(name.length).to be > 0
        end
        
        it "Has a array of extensions or null" do
          extensions = @artworks[0]["extensions"]
          expect(extensions).to be_nil.or be_an_instance_of(Array)
        end
        
        it "Has a link from google" do
          link = @artworks[0]["link"]
          expect(link).to be_an_instance_of(String)
          expect(link.start_with?("https://www.google.com")).to be true
        end
        
        it "Has a image to be null or data url" do
          image = @artworks[0]["image"]
          expect(image).to be_nil.or start_with("data:image/")
        end
      
      end
    end
  end
end