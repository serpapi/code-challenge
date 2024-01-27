require 'spec_helper'

require_relative '../lib/parser'
require_relative '../lib/fetcher'
require 'pry'

describe Parser do
  describe "#to_serializable_hash" do
    subject(:results) do
      parser.to_serializable_hash
    end

    let(:parser) do
      described_class.new(input_io)
    end

    let(:input_io) do
      file =  File.expand_path(
        File.join(
          File.dirname(__FILE__), "../files/van-gogh-paintings.html"
        )
      )
      Fetcher.new(file).rendered
    end

    context "when we have a known test file" do
      it "should provide expected results" do
        expect(results).to be_kind_of(Hash)
        expect(results.keys).to contain_exactly("knowledge_graph")

        graph = results["knowledge_graph"]
        aggregate_failures "knowledge_graph" do
          expect(graph).to be_kind_of(Hash)
          expect(graph.keys).to contain_exactly("artworks")
        end

        artworks = graph["artworks"]

        aggregate_failures "artworks" do
          expect(artworks).to be_kind_of Array
          expect(artworks.size).to eq 51
        end

        aggregate_failures "case where all fields present" do
          art = artworks[0]
          expect(art).to match(
            "name" => "The Starry Night",
            "extensions" => [ "1889" ],
            "link" => "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
            "image" => be_kind_of(String)
          )
        end

        aggregate_failures "case where extensions missing" do
          art = artworks[2]
          expect(art.keys).to contain_exactly("name", "link", "image")
        end

        aggregate_failures "case where image is missing" do
          art = artworks[-1]
          expect(art.keys).to contain_exactly("name", "link", "image", "extensions")
          expect(art["image"]).to eq nil
        end
      end
    end
  end
end