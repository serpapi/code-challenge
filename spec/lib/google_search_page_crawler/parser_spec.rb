require 'spec_helper'

describe GoogleSearchPageCrawler::Parser do

  describe ".parse_small_carrousel_artwork" do

    let(:artwork_html) {
      load_fixture_file("small-carrousel-nodes.html")
    }

    subject { GoogleSearchPageCrawler::Parser.new(artwork_html) }

    let(:artwork_node) {
      Nokogiri::HTML(artwork_html).css(".TEST-BASE64-IMAGE").first
    }

    specify "name" do
      expect(subject.parse_small_carrousel_artwork(artwork_node).name).to eq("Mona Lisa")
    end

    specify "extensions" do
      expect(subject.parse_small_carrousel_artwork(artwork_node).extensions).to eq(["1503"])
    end

    specify "artwork link" do
      expect(subject.parse_small_carrousel_artwork(artwork_node).link).to eq("https://www.google.com/search?sca_esv=e77f9c08ad4d25ad&biw=1586&bih=1035&sxsrf=AE3TifN2iTKwYxF5z6Sia-R7MToRTCNBWw:1755200456837&q=Mona+Lisa&stick=H4sIAAAAAAAAAONgFuLQz9U3MMlJN1MCs7KS0o20lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWLWDl98_MSFXwyixMBIBd7QkYAAAA&sa=X&ved=2ahUKEwiv6PSdh4uPAxXSq5UCHd6QHDcQgOQBegQIKRAG")
    end

    describe "image" do
      context "base64 image thumbnail" do
        let(:artwork_node) {
          Nokogiri::HTML(artwork_html).css(".TEST-BASE64-IMAGE").first
        }
        specify "image" do
          expect(subject.parse_small_carrousel_artwork(artwork_node).image).to eq("data:image/png;base64,IMAGE_BASE64_ENCODED")
        end
      end

      context "from data-src attribute" do
        let(:artwork_node) {
          Nokogiri::HTML(artwork_html).css(".TEST-SRC-IMAGE").first
        }

        specify "image" do
          expect(subject.parse_small_carrousel_artwork(artwork_node).image).to eq("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmsSqNIpDECcqeJjSrhtrs-BACeA8OpmvELK_NisutLtuK0z1j9bXbtOvYm54&s=10")
        end
      end
    end
  end

  describe ".parse_big_carrousel_artwork" do

    let(:artwork_html) {
      load_fixture_file("starry_night_big_carrousel_node.html")
    }

    subject { GoogleSearchPageCrawler::Parser.new(artwork_html) }

    let(:artwork_node) {
      Nokogiri::HTML(artwork_html).css("a").first
    }

    specify "name" do
      expect(subject.parse_big_carrousel_artwork(artwork_node).name).to eq("The Starry Night")
    end

    specify "extensions" do
      expect(subject.parse_big_carrousel_artwork(artwork_node).extensions).to eq(["1889"])
    end

    specify "artwork link" do
      expect(subject.parse_big_carrousel_artwork(artwork_node).link).to eq("https://www.google.com/search?sca_esv=c2e426814f4d07e9&gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&sa=X&ved=2ahUKEwjK-K-JwLWKAxXcQTABHePpOFoQtq8DegQIMxAD")
    end

    describe "image" do
      context "from data-src attribute" do
        let(:artwork_node) {
          Nokogiri::HTML(artwork_html).css("a.TEST-DATA-SRC").first
        }

        specify "image" do
          expect(subject.parse_big_carrousel_artwork(artwork_node).image).to eq("DATA_SRC_CONTENT")
        end
      end

      context "base64 image thumbnail" do
        let(:artwork_node) {
          Nokogiri::HTML(artwork_html).css("a.TEST-BASE64-IMAGE").first
        }
        specify "image" do
          expect(subject.parse_big_carrousel_artwork(artwork_node).image).to eq("data:image/png;base64,IMAGE_BASE64_ENCODED")
        end
      end
    end
  end
end