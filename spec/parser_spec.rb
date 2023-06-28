# frozen_string_literal: true

require_relative "../lib/parser"
require "oj"
require "json"

RSpec.describe Parser do
  describe ".parse" do
    let(:parsed_content) { described_class.parse(file) }

    context "when parsing v1 search result file" do
      let(:file) { "../files/van-gogh-paintings.html" }
      # expected json file is not properly formatted, it lacks enclosing braces
      let(:expected_json) { Oj.load("{#{File.read('./files/van-gogh-expected-array.json')}}") }

      it "returns the correct expected json" do
        expect(parsed_content).to eq(expected_json)
      end
    end

    context "when parsing v2 search result file" do
      context "when parsing Pablo Picasso Periods" do
        let(:file) { "../files/pablo-picasso-periods-v2.html" }
        let(:expected_json) { Oj.load(File.read("./files/pablo-picasso-periods-expected-array-v2.json")) }

        it "returns the correct expected json" do
          expect(parsed_content).to eq(expected_json)
        end
      end

      context "when parsing Leonardo da Vinci structures" do
        let(:file) { "../files/leonardo-da-vinci-structures-v2.html" }
        let(:expected_json) { Oj.load(File.read("./files/leonardo-da-vinci-expected-array-v2.json")) }

        it "returns the correct expected json" do
          expect(parsed_content).to eq(expected_json)
        end
      end
    end
  end
end
