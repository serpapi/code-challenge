require "spec_helper"
require "scraper"
require "json"

describe Scraper do
  context "van gogh paintings" do
    let(:subject) { Scraper.new("spec/fixtures/van-gogh-paintings.html") }
    let(:expected) { JSON.load(File.open("spec/fixtures/expected-array.json"))["artworks"] }

    let(:results) { subject.scrape_carousel }

    it "matches exactly with the expected results" do
      results.each_with_index do |result, i|
        expect(expected[i]["name"]).to eq(result[:name])
        expect(expected[i]["extensions"]).to eq(result[:extensions])
        expect(expected[i]["link"]).to eq(result[:link])
        expect(expected[i]["image"]).to eq(result[:image])
      end
    end
  end
end
