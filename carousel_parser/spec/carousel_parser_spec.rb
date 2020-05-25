require "addressable/uri"

PARENT_DIR = File.expand_path("..", Dir.pwd)
HTML_TESTS_DIR = File.join(PARENT_DIR, "files")
%w[
  van-gogh-paintings.html
  tom-hanks-movies.html
  stephen-king-books.html
].each do |filename|
  RSpec.describe "CarouselParser for (#{filename})" do
    before do
      file = File.open(File.join(HTML_TESTS_DIR, filename))
      @carousel_objects = CarouselParser.get_carousel_objects(file)
    end

    it "contains carousel items" do
      expect(@carousel_objects.length).to be > 1
      expect(@carousel_objects.length).to eq (51)
    end

    it "contains required fields" do
      @carousel_objects.each do |item|
        expect(item.has_key?(:name)).to be true
        expect(item.has_key?(:extensions)).to be true
        expect(item.has_key?(:link)).to be true
        expect(item.has_key?(:image)).to be true
      end
    end

    it "extensions is Array" do
      @carousel_objects.each do |item|
        expect(item[:extensions]).to be_a(Array)
      end
    end

    it "name is String" do
      @carousel_objects.each do |item|
        expect(item[:name]).to be_a(String)
        expect(item[:name]).to_not be_empty
      end
    end

    it "image is String" do
      @carousel_objects.each do |item|
        expect(item[:image]).to be_a(String)
        expect(item[:image]).to_not be_empty
      end
    end


    it "link is String" do
      @carousel_objects.each do |item|
        expect(item[:link]).to be_a(String)
        expect(item[:link]).to_not be_empty
      end
    end

    it "link is valid URL and contains query" do
      @carousel_objects.each do |item|
        uri = Addressable::URI.parse(item[:link])
        expect(uri.query_values["q"]).to_not be_empty
      end
    end
  end
end
