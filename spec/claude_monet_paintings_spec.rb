require "./lib/knowledge_graph_artwork.rb"

describe "Claude Monet Paintings" do

  before :all do
    @response = File.open("./files/van-gogh-paintings.html").read
    @json = KnowledgeGraphArtwork.parse(@response)
  end

  it "contains Knowledge Graph hash" do
    expect(@json).to be_an(Hash)
  end
end
