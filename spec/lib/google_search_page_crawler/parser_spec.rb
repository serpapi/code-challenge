require 'spec_helper'

describe GoogleSearchPageCrawler::Parser do

  describe ".parse_artwork" do
    subject { GoogleSearchPageCrawler::Parser.new("") }

    let(:artwork_html) {
      load_fixture_file("starry_night_artwork_node.html")
    }

    let(:artwork_node) {
      Nokogiri::HTML(artwork_html).css("a").first
    }

    specify "name" do
      expect(subject.parse_artwork(artwork_node)[:name]).to eq("The Starry Night")
    end

    specify "extensions" do
      expect(subject.parse_artwork(artwork_node)[:extensions]).to eq(["1889"])
    end

    specify "artwork link" do
      expect(subject.parse_artwork(artwork_node)[:link]).to eq("https://www.google.com/search?sca_esv=c2e426814f4d07e9&gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&sa=X&ved=2ahUKEwjK-K-JwLWKAxXcQTABHePpOFoQtq8DegQIMxAD")
    end

    specify "image" do
      expect(subject.parse_artwork(artwork_node)[:image]).to eq("IMAGE_DATA")
    end
  end

  describe "parse" do
    let(:html) {
      load_fixture_file("van-gogh-paintings.html")
    }

    subject { GoogleSearchPageCrawler::Parser.new(html) }

    specify "artworks" do
      result = subject.parse
      expected_artworks = JSON.parse(load_fixture_file("van-gogh-expected-parse-response.json"))["artworks"]

      expect(result[:artworks].size).to eq(47)
      expect(result[:artworks].map { |a| a[:name] }).to eq(expected_artworks.map { |a| a["name"] })
      expect(result[:artworks].map { |a| a[:extensions] }).to eq(expected_artworks.map { |a| a["extensions"] })
    end
  end
end