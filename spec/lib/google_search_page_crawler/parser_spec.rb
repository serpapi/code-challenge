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
  end
end