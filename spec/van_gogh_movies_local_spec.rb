require_relative '../lib/item_list_extractor_local'

describe "Van Gogh Paintings" do

  before :all do
    @array = ItemListExtractorLocal.new("./files/other/van-gogh-movies.html").extract
  end

  it "contains itens array" do
    expect(@array).to be_an(Array)
    expect(@array).to_not be_empty
  end

  it "item name property" do
    @array.each do |item|
      expect(item[:name]).to be_an(String)
      expect(item[:name]).to_not be_empty
    end
  end

  it "item extensions property" do
    @array.each do |item|
      expect(item[:extensions]).to be_an(Array)
      if item[:extensions].any?
        expect(item[:extensions].first).to be_an(String)
        expect(item[:extensions].first).to_not be_empty
      end
    end
  end

  it "item link property" do
    @array.each do |item|
      expect(item[:link]).to be_an(String)
      expect(item[:link]).to_not be_empty
    end
  end

  it "item image property" do
    @array.each do |item|
      if item[:image]
        expect(item[:image]).to be_an(String)
        expect(item[:image]).to_not be_empty
      end
    end
  end

end