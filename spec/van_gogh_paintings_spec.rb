require "./lib/knowledge_graph_artwork.rb"

describe "Van Gogh Paintings" do

  before :all do
    @response = File.open("./files/van-gogh-paintings.html").read
    @parser = KnowledgeGraphArtwork.parse(@response)
  end

  it "finds the page title" do
    expect(@parser.title).to eq("Van Gogh paintings - Google Search")
  end
end
