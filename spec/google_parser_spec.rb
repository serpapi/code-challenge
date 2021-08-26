require "google_parser"
require 'json'

describe GoogleParser do
  let!(:results) { described_class.new.call }
  let!(:paintings) do
    JSON.parse(File.read(Dir.pwd + "/spec/paintings.json"))
  end

  describe ".call" do
    it "should return the correct array of paintings" do
      expect(JSON.parse(results)).to eq(paintings)
    end
  end
end