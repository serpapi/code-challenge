# frozen_string_literal: true

require "google/carousel_v2"

RSpec.describe Google::CarouselV2 do
  subject(:parser) { described_class.new(doc) }

  describe "#parseable?" do
    it "returns true when the document contains a g-scrolling-carousel node" do
      doc = html_fixture(google_search_results("Monet"))
      parser = described_class.new(doc)
      expect(parser).to be_parseable
    end

    it "returns false when the document does not contain a .klitem node" do
      doc = html_fixture(google_search_results("Van Gogh paintings"))
      parser = described_class.new(doc)
      expect(parser).not_to be_parseable
    end
  end

  context "with search results for 'Monet'" do
    describe "#items" do
      let(:doc) { html_fixture(google_search_results("Monet")) }
      let(:expected_list) { json_fixture("monet-expected")[:artworks] }

      it "returns the expected number of items" do
        expect(parser.items.size).to eq(expected_list.size)
      end

      it "returns the expected list of names" do
        parser.items.zip(expected_list).each do |item, expected|
          expect(item.name).to eq(expected[:name])
        end
      end

      it "returns the expected list of extensions" do
        parser.items.zip(expected_list).each do |item, expected|
          expect(item.extensions).to eq(expected[:extensions])
        end
      end

      it "returns the expected list of links" do
        parser.items.zip(expected_list).each do |item, expected|
          expect(item.link).to eq(expected[:link])
        end
      end

      it "returns the expected list of images" do
        parser.items.zip(expected_list).each do |item, expected|
          expect(item.image).to eq(expected[:image])
        end
      end
    end
  end
end
