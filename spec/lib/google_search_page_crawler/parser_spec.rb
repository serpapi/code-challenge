require 'spec_helper'

describe GoogleSearchPageCrawler::Parser do

  subject { GoogleSearchPageCrawler::Parser.new("") }

  describe ".parse_artwork" do
    let(:artwork_html) {
      load_fixture_file("starry_night_artwork_node.html")
    }

    let(:artwork_node) {
      Nokogiri::HTML(artwork_html)
    }

    it "fetches the title" do
      expect(subject.parse_artwork(artwork_node)[:title]).to eq("The Starry Night")
    end

    it "fetches the extensions" do
      expect(subject.parse_artwork(artwork_node)[:extensions]).to eq(["1889"])
    end

    it "fetches the artwork link" do
      expect(subject.parse_artwork(artwork_node)[:link]).to eq("https://www.google.com/search?sca_esv=c2e426814f4d07e9&gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&sa=X&ved=2ahUKEwjK-K-JwLWKAxXcQTABHePpOFoQtq8DegQIMxAD")
    end
  end
end