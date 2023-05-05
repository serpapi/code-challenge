require "parser"
require 'ferrum'

RSpec.describe Parser, "#to_json" do
  context "with van gogh paintings search" do
    let(:html) {
      browser = Ferrum::Browser.new
      browser.network.intercept
      browser.on(:request) { |req| req.respond(body: File.read("files/van-gogh-paintings.html")) }
      browser.go_to("https://www.google.com/search?q=Van+Gogh+paintings")
      html = browser.body
      browser.quit

      html
    }

    it "returns correct json schema" do
      parser = Parser.new(html)

      expect(parser.to_json).to match_response_schema('van-gogh-paintings')
    end

    it "returns expected json" do
      parser = Parser.new(html)

      expect(parser.to_json).to match_json_response("van-gogh-paintings")
    end

    it "returns empty array with minimal html" do
      parser = Parser.new("<div></div>")

      expect(JSON.parse(parser.to_json)).to eq({"artworks" => []})
    end
  end
end
