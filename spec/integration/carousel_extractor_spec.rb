require "spec_helper"
require "json"
require "carousel_extractor"

SOURCE_HTML_DIR = File.join(__dir__, "../fixtures/source-html")
JSON_RESULT_DIR = File.join(__dir__, "../fixtures/json-result")

Dir["#{SOURCE_HTML_DIR}/*.html"].each do |html_file|
  basename = File.basename(html_file, ".html")
  json_file = "#{JSON_RESULT_DIR}/#{basename}.json"

  RSpec.describe "CarouselExtractor — #{basename}", :integration do
    let(:results)  { CarouselExtractor.new(File.read(html_file)).extract }
    let(:expected) { JSON.parse(File.read(json_file))["artworks"] }

    it "extracts the correct number of artworks" do
      expect(results.length).to eq(expected.length)
    end

    it "matches each artwork" do
      results.each_with_index do |result, i|
        exp = expected[i].transform_keys(&:to_sym)
        expect(result).to eq(exp)
      end
    end
  end
end
