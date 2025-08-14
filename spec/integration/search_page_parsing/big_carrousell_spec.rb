require 'spec_helper'

describe "Search Page Parsing" do

  describe "Big Carrousell" do
    let(:html) {
      load_fixture_file("van-gogh-paintings.html")
    }

    subject { GoogleSearchPageCrawler::Parser.new(html) }

    specify "artworks" do
      result = subject.parse
      expected_artworks = JSON.parse(load_fixture_file("van-gogh-expected-parse-response.json"))["artworks"]

      expect(result[:artworks].size).to eq(47)
      expect(result[:artworks].map { |a| a[:name] }).to eq(expected_artworks.map { |a| a["name"] })
      expect(result[:artworks].map { |a| a[:link] }).to eq(expected_artworks.map { |a| a["link"] })
      # binding.break
      # expect(result[:artworks].map { |a| a[:image].to_s }).to eq(expected_artworks.map { |a| a["image"].to_s })
      # binding.break
      # expect(result[:artworks].map { |a| a[:extensions] }).to eq(expected_artworks.map { |a| a["extensions"] })
    end
  end
end