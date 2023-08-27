# frozen_string_literal: true

RSpec.describe Challenge do
  describe "check parsing for classic google search carousel" do
    before :all do
      @json = JSON.parse(Challenge.process_page)
    end

    it "contains the artwork array" do
      expect(@json["artworks"]).to be_an(Array)
      expect(@json["artworks"]).to_not be_empty
    end

    it "artworks -- have name" do
      expect(@json["artworks"][0]["name"]).to be_an(String)
      expect(@json["artworks"]).to_not be_empty
    end

    it "artworks -- have extensions" do
      expect(@json["artworks"][0]["extensions"]).to be_an(Array)
      expect(@json["artworks"]).to_not be_empty
    end

    it "artworks -- have link" do
      expect(@json["artworks"][0]["link"]).to be_an(String)
      expect(@json["artworks"]).to_not be_empty
    end

    it "artworks -- have image" do
      expect(@json["artworks"][0]["image"]).to be_an(String)
      expect(@json["artworks"]).to_not be_empty
    end

    it "some artworks -- have no extensions" do
      expect(@json["artworks"][2]["extensions"]).to be_nil
    end

    it "some artworks -- have no images" do
      expect(@json["artworks"][50]["image"]).to be_nil
    end
  end
end
