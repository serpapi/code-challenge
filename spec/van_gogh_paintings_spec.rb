require "./lib/knowledge_graph_artwork.rb"

describe "Van Gogh Paintings" do

  before :all do
    @response = File.open("./files/van-gogh-paintings.html").read
    @parser = KnowledgeGraphArtwork.parse(@response)
  end

  it "finds the page title" do
    expect(@parser.title).to eq("Van Gogh paintings - Google Search")
  end

  it "finds Artwork" do
    expect(@parser.artwork.length).to eq(51)
  end

  it "Artwork should have name, date, and link" do
    expect(@parser.artwork.first.keys).to eq([:name, :date, :link])
  end

  describe "extracting the name" do

    it "First Artwork name should exclude the date" do
      expect(@parser.artwork.first[:name]).to eq("The Starry Night")
    end

    it "last Artwork name should exclude the date" do
      expect(@parser.artwork.last[:name]).to eq("Portrait of Adeline Ravoux")
    end
  end

  describe "extracting the date" do
    it "First Artwork should parse date" do
      expect(@parser.artwork.first[:date]).to eq(["1889"])
    end

    it "last Artwork should parse date" do
      expect(@parser.artwork.last[:date]).to eq(["1890"])
    end
  end

  describe "extracting the link" do
    it "FIRST Artwork should parse the link href" do
      expect(@parser.artwork.first[:link]).to eq("https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw")
    end

    it "LAST Artwork should parse the link href" do
      expect(@parser.artwork.last[:link]).to eq("https://www.google.com/search?gl=us&hl=en&q=Portrait+of+Adeline+Ravoux&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyyjYzTq7SUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVKiC_qKQoMbNEIT9NwTElNSczL1UhKLEsv7QCAOSAHzG2AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIxQE")
    end
  end
end
