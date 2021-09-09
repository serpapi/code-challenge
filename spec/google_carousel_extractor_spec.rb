require "json"
require "./app/google_carousel_extractor"

describe GoogleCarouselExtractor do
  [
    {file_path: "files/van-gogh-paintings.html"},
    {file_path: "files/latest-sample-1.html"},
    {file_path: "files/latest-sample-2.html"}
  ].each do |params|
    before :all do
      @extractor = GoogleCarouselExtractor.new()
      @result = @extractor.extract_from_file(File.join(File.dirname(__FILE__), "../" + params[:file_path]))
    end

    describe "result" do
      {
        name: String,
        extensions: Array,
        link: String,
        image: String
      }.each do |attribute, type|
        it "Has a #{attribute}" do
          expect(@result[0][attribute]).to be_a_kind_of(type).and(be_truthy)
        end
      end
    end
  end
end