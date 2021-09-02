require "json"
require "./app/google_carousel_extractor"

describe GoogleCarouselExtractor do
  before do
    @extractor = GoogleCarouselExtractor.new()
  end

  it "extract successfully from Van Gogh Paintings" do
    result = @extractor.extract_from_file("./files/van-gogh-paintings.html")
    expectedResult = JSON.load File.read("./spec/van-gogh-paintings-expected-array.json")
    expect(result).to match_array(expectedResult['artworks'])
  end

  it "extract successfully from latest sample 1" do
    sampleFile = File.read("./files/latest-sample-1.html")
    expect(OpenURI).to receive(:open_uri).and_return(sampleFile)

    result = @extractor.extract_from_url("https://www.google.com/search?q=spider+man+no+way+home+cast&oq=spider+man+no+way+home+cast")
    expectedResult = JSON.load File.read("./spec/latest-sample-1-expected-array.json")
    expect(result).to match_array(expectedResult['cast'])
  end

  it "extract successfully from latest sample 2" do
    sampleFile = File.read("./files/latest-sample-2.html")
    expect(OpenURI).to receive(:open_uri).and_return(sampleFile)

    result = @extractor.extract_from_url("https://www.google.com/search?q=favourite+comics&oq=favourite+comics")
    expectedResult = JSON.load File.read("./spec/latest-sample-2-expected-array.json")
    expect(result).to match_array(expectedResult['comic_books'])
  end
end