require_relative '../lib/paintings_parser.rb'

describe("Paintings Parser") do
  before :all do
    path   = './support/result.html'
    parser = PaintingsParser.create_parser_for(path)
    json   = parser.parse
    @artworks  = JSON.parse(json)["artworks"]
    @first_result = @artworks[0]
  end

  it "contains artworks array" do
    expect(@artworks).to be_an(Array)
  end

  it "parses painting name" do
    expect(@first_result["name"]).to eq("The Starry Night")
  end

  it "parses paiting extensions" do
    expect(@first_result["extensions"]).to be_an(Array)
    expect(@first_result["extensions"].length).to be(1)
    expect(@first_result["extensions"][0]).to eq("1889")
  end

  it "parses painting link" do
    expect(@first_result["link"]).to eq("https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw")
  end

  it "parses painting image" do
    # The actual base64-string is humongous, so we just test for presence.
    expect(@first_result["image"]).to_not be_empty
  end

  describe "create_parser" do
    it "creates a paintings parser" do
      path = './support/result.html'
      expect(PaintingsParser.create_parser_for(path)).to_not be_nil
    end

    it "raises an error if the results file doesn't exists" do
      expect {
        path   = '/not/an/existing/file.txt'
        parser = PaintingsParser.create_parser_for(path)
      }.to raise_error(ArgumentError)
    end

    it "raises an error if the results file is not an html file" do
      expect {
        path   = './support/result.txt'
        parser = PaintingsParser.create_parser_for(path)
      }.to raise_error(ArgumentError)
    end
  end
end

