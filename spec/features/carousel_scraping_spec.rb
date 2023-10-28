require_relative "../../services/carousel_scraper_service"

RSpec.describe "scraping Google search results" do
  subject(:scraper) do
    CarouselScraperService.new(input_file:)
  end

  describe "scraping carousel images from an HTML file" do
    context "with Van Gogh paintings" do
      let(:input_file) { "spec/fixtures/van-gogh-paintings.html" }
      let(:expected_result) { JSON.parse(File.read("spec/fixtures/expected-array-van-gogh.json")) }

      it "returns the expected parsed array" do
        expect(JSON.parse(scraper.call)["artworks"]).to match_array(expected_result["artworks"])
      end
    end

    context "with Degas paintings" do
      let(:input_file) { "spec/fixtures/edgar-degas-paintings.html" }
      let(:expected_result) { JSON.parse(File.read("spec/fixtures/expected-array-degas.json")) }

      it "returns the expected parsed array" do
        expect(JSON.parse(scraper.call)["artworks"]).to match_array(expected_result["artworks"])
      end
    end

    context "with movies" do
      let(:input_file) { "spec/fixtures/movies.html" }
      let(:expected_result) { { "movies" => [] } }
      let(:expected_result) { JSON.parse(File.read("spec/fixtures/expected-array-movies.json")) }

      it "returns the expected parsed array" do
        expect(JSON.parse(scraper.call)["movies"]).to match_array(expected_result["movies"])
      end
    end
  end
end
