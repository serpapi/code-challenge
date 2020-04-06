# typed: false
# frozen_string_literal: true

require "./src/core_ext"

RSpec.describe "String" do
  describe "#not_empty" do
    it "returns nil for empty inputs" do
      expect("".not_empty).to eq(nil)
    end

    it "returns the string when not empty" do
      expect("something".not_empty).to eq("something")
    end
  end
end
