# frozen_string_literal: true

require "spec_helper"
require "nokogiri"
require_relative "../lib/van_scraper"

describe "VanScraper" do
  let(:van_gogh_file) { "spec/fixtures/van-gogh-paintings.html" }
  let(:google_home_file) { "spec/fixtures/google-home.html" }
  let(:file) { File.read(van_gogh_file) }
  let(:doc) { Nokogiri::HTML(file) }
  let(:carrousel) { doc.xpath("//g-scrolling-carousel") }

  describe ".parse" do
    context "when called without arguments" do
      it "responds with an error" do
        expect { VanScraper.parse }.to raise_error(ArgumentError)
      end
    end

    context "when called with a file path to a google page" do
      context "when the file path is nil" do
        it "responds with an error" do
          expect { VanScraper.parse(nil) }.to raise_error("Missing file_path for parsing")
        end
      end

      context "when the file does not contain a google carrousel" do
        it "responds with an error" do
          expect { VanScraper.parse(google_home_file) }.to raise_error("Page does not contain google carrousel")
        end
      end

      context "when the file is valid" do
        it "returns Artworks class and list of paintings" do
          artworks = VanScraper.parse(van_gogh_file)
          expect(artworks.class).to eq(VanScraper::Artworks)
          expect(artworks.paintings.length).to be > 1
        end
      end
    end
  end

  describe "::Artworks" do
    it "returns an Artwork object with an array of Painting objects" do
      paintings = VanScraper::Artworks.new(carrousel).paintings
      expect(paintings).to be_an_instance_of(Array)
      expect(paintings.length).to be > 1
      expect(paintings.first.class).to eq(VanScraper::Painting)
    end
  end

  describe "::Painting" do
    let(:node) { carrousel.css(".klitem").first }

    it "returns a Painting object with the normalized data" do
      painting = VanScraper::Painting.new(node)
      expect(painting.name).to eq("The Starry Night")
      expect(painting.extensions).to eq(["1889"])
      expect(painting.image).to eq("data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")
    end
  end
end
