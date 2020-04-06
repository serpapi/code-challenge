# typed: false
# frozen_string_literal: true

require "./src/google_search_carousel"

RSpec.describe "GoogleSearchCarousel" do
  describe "#extract" do
    context "when given a page without a carousel" do
      it "returns an empty array" do
        items = GoogleSearchCarousel.new(IO.read("spec/files/summary-of-the-bell-jar.html")).extract
        expect(items).to be_empty
      end
    end
  end
end
