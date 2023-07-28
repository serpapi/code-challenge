require_relative 'spec_helper'

describe "Parse Google Search results" do

  describe "Search results for Michelangelo Sculptures" do
    before(:all) do
      @michelangelo_results = parse_google_search_results("Michelangelo Sculptures", @browser)
    end

    it "returns an array of search results" do
      expect(@michelangelo_results).to be_an(Array)
      expect(@michelangelo_results).not_to be_empty
    end

    it "each result contains a title, extensions, link, and image" do
      @michelangelo_results.each do |result|
        expect(result[:name]).to be_a(String)
        expect(result[:extensions]).to be_an(Array)
        expect(result[:link]).to be_a(String)
        expect(result[:image]).to be_a(String)
      end
    end
  end

  describe "Search results for Renaissance Artwork" do
    before(:all) do
      @renaissance_results = parse_google_search_results("Renaissance Artwork", @browser)
    end

    it "returns an array of search results" do
      expect(@renaissance_results).to be_an(Array)
      expect(@renaissance_results).not_to be_empty
    end

    it "each result contains a title, extensions, link, and image" do
      @renaissance_results.each do |result|
        expect(result[:name]).to be_a(String)
        expect(result[:extensions]).to be_an(Array)
        expect(result[:link]).to be_a(String)
        expect(result[:image]).to be_a(String)
      end
    end
  end
end