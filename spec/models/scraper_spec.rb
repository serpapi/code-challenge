require "spec_helper"
require "scraper"
require "json"

describe Scraper do
  context "van gogh paintings" do
    let(:subject) { Scraper.new("spec/fixtures/van-gogh-paintings.html") }
    let(:expected) { JSON.load(File.open("spec/fixtures/expected-array.json"))["artworks"] }

    let(:results) { subject.scrape_carousel }

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
end
