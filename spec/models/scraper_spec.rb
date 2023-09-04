require "spec_helper"
require "scraper"
require "json"

describe Scraper do
  context "van gogh paintings" do
    let(:subject) { Scraper.new("spec/fixtures/van-gogh-paintings.html") }
    let(:expected) { JSON.load(File.open("spec/fixtures/expected-array.json"))["artworks"] }

    let(:results) { subject.scrape_carousel }

    it "scrapes the exact number of results" do
      expect(expected.size).to eq(results.size)
    end

    it "matches names with expected results" do
      results.each_with_index do |result, i|
        expect(expected[i]["name"]).to eq(result[:name])
      end
    end

    it "matches extensions with expected results" do
      results.each_with_index do |result, i|
        expect(expected[i]["extensions"]).to eq(result[:extensions])
      end
    end

    it "matches link with expected results" do
      results.each_with_index do |result, i|
        expect(expected[i]["link"]).to eq(result[:link])
      end
    end

    it "matches image with expected results" do
      results.each_with_index do |result, i|
        expect(expected[i]["image"]).to eq(result[:image])
      end
    end
  end

  context "other types of searches" do
    ["dogs", "noodles", "paintings"].each do |search_name|
      let(:subject) { Scraper.new("spec/fixtures/#{search_name}.html") }
      let(:results) { subject.scrape_carousel }

      it "extracts data corrrectly" do
        results.each do |result|
          expect(result[:name]).to be_a String
          expect(result[:extensions]).to be_a Array
          expect(result[:link]).to be_a String
          expect(result[:image]).to be_a String if result[:image]
        end
      end
    end
  end
end
