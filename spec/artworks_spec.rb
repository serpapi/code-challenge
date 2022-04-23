$LOAD_PATH << '.'

require 'Arts'
describe "SerpApi Desktop JSON" do

  describe "Knowledge Graph for Claude Monet Paintings" do

    before :all do
      source_html_path = './files/van-gogh-paintings.html'
      @artworks = Arts::Artworks.new(source_html_path).artworks
    end

    it "artworks" do
      expect(@artworks).to be_a(Array)
      expect(@artworks).to_not be_empty
    end

    it "artworks - name" do
      expect(@artworks[0].name).to be_a(String)
      expect(@artworks[0].name).to_not be_empty
    end

    it "artworks - extensions" do
      expect(@artworks[0].extensions).to be_a(Array)
      expect(@artworks[0].extensions).to_not be_empty
    end

    it "artworks - link" do
      expect(@artworks[0].link).to be_a(String)
      expect(@artworks[0].link).to_not be_empty
    end

    it "artworks - image" do
      expect(@artworks[0].image).to be_a(String)
      expect(@artworks[0].image).to_not be_empty
    end

  end

end