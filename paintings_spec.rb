require 'rspec'

require_relative 'paintings'
require 'json'

CUR_DIR = File.dirname(__FILE__)

PAINTER_DESC = [
  {
  :name => 'Van Gogh',
  :file => 'van-gogh-paintings.html',
  :standard_index => 0,
  :no_extensions_index => 2,
  :no_image_index => 8
  },
  {
    :name => 'Monet',
    :file => 'monet-paintings.html',
    :standard_index => 0,
    :no_extensions_index => 24,
    :no_image_index => 8
  },
  {
    :name => 'Michelangelo',
    :file => 'michelangelo-paintings.html',
    :standard_index => 0,
    :no_extensions_index => 4,
    :no_image_index => 8
  }

]

PAINTER_DESC.each do
  |painter_desc|

  describe "#{painter_desc[:name]} paintings" do
    before :all do
      @data = Paintings::paintings(File.join(CUR_DIR, "files", painter_desc[:file]))
    end

    it "has artworks array" do
      expect( @data ).to be_an(Hash)
      expect( @data[:artworks] ).to be_an(Array)
    end

    describe "items" do
      before :all do
        @standard_item = @data[:artworks][painter_desc[:standard_index]]
        @no_extensions_item = @data[:artworks][painter_desc[:no_extensions_index]]
        @no_image_item = @data[:artworks][painter_desc[:no_image_index]]
      end
      it "name" do
        expect( @standard_item[:name] ).to be_a(String)
      end

      it "link" do
        expect( @standard_item[:link] ).to be_a(String)
        expect( @standard_item[:link] ).to_not be_empty
      end

      it "extensions" do
        expect( @standard_item[:extensions] ).to be_an(Array)
        expect( @standard_item[:extensions][0] ).to be_a(String)
        expect( @no_extensions_item[:extensions] ).to be(nil)
      end

      it "image" do
        expect(@standard_item[:image]).to be_a(String)
        expect(@no_image_item[:image]).to be(nil)
      end
    end
  end
end